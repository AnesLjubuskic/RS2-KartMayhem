using AutoMapper;
using KartMayhem.Model.Exception;
using KartMayhem.Model.SearchObject;
using KartMayhem.Model.UserRequestObjects;
using KartMayhem.Services.Database;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.Services
{
    public class KorisniciService : BaseService<Model.Korisnici, Database.Korisnici, Model.SearchObject.KorisniciSearchObject>, IKorisniciService
    {
        public KorisniciService(KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public async Task<bool> CancelRewardUser(int userId)
        {
            var korisnici = _context.Set<Database.Korisnici>()
                            .Include(x => x.Nagrada)
                            .FirstOrDefault(x => x.Id == userId);

            if (korisnici == null)
            {
                throw new UserException("Korisnik ne postoji", "Korisnik ne postoji!");
            }

            if (korisnici.Nagrada == null)
            {
                throw new UserException("Korisnik ne posjeduje nagradu", "Korisnik ne posjeduje nagradu!");
            }

            korisnici.Nagrada = null;

            await _context.SaveChangesAsync();

            return true;
        }

        public async Task<bool> RewardUser(int userId)
        {
            var korisnici = _context.Set<Database.Korisnici>()
                .Include(x => x.Nagrada)
                .FirstOrDefault(x => x.Id == userId);

            if (korisnici == null)
            {
                throw new UserException("Korisnik ne postoji", "Korisnik ne postoji!");
            }

            if (korisnici.Nagrada != null)
            {
                throw new UserException("Korisnik posjeduje nagradu", "Korisnik posjeduje nagradu!");
            }

            var nagrada = _context.Set<Database.Nagrade>().FirstOrDefault();

            korisnici.Nagrada = nagrada;

            await _context.SaveChangesAsync();

            return true;
        }

        public async Task<List<Model.Korisnici>> TopUsers()
        {
            var korisnici = _context.Set<Database.Korisnici>()
                .Include(x => x.Nagrada)
                .Where(x => x.IsActive)
                .OrderByDescending(x => x.BrojRezervacija)
                .Take(5);

            var korisniciDto = _mapper.Map<List<Model.Korisnici>>(korisnici);

            foreach (var korisnik in korisniciDto)
            {
                korisnik.IsNagrada = korisnik.Nagrada != null;
            }

            return korisniciDto;
        }

        public override IQueryable<Korisnici> AddFilter(IQueryable<Korisnici> query, KorisniciSearchObject? search = null)
        {
            var filter = base.AddFilter(query, search);

            filter = filter.Where(x => x.IsActive);

            if (search != null && !string.IsNullOrWhiteSpace(search.Ime))
            filter = filter.Where(x => x.Ime.ToLower().Contains(search.Ime.ToLower()) || x.Prezime.ToLower().Contains(search.Ime.ToLower()));

            return filter;
        }

        public async Task<bool> DeactivateUser(int userId)
        {
            var korisnici = _context.Set<Database.Korisnici>().Find(userId);

            if (korisnici == null)
            {
                throw new UserException("Korisnik ne postoji", "Korisnik ne postoji!");
            }

            korisnici.IsActive = false;

            await _context.SaveChangesAsync();

            return true;
        }
    }
}
