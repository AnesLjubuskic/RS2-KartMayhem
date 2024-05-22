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
                throw new UserException("Korisnik ne postoji!");
            }

            if (korisnici.Nagrada == null)
            {
                throw new UserException("Korisnik ne posjeduje nagradu!");
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
                throw new UserException("Korisnik ne postoji!");
            }

            if (korisnici.Nagrada != null)
            {
                throw new UserException("Korisnik posjeduje nagradu!");
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
                filter = filter.Where(x => (x.Ime.ToLower() + x.Prezime.ToLower()).Contains(search.Ime.ToLower()));

            return filter;
        }

        public async Task<bool> DeactivateUser(int userId)
        {
            var korisnici = _context.Set<Database.Korisnici>().Find(userId);

            if (korisnici == null)
            {
                throw new UserException("Korisnik ne postoji!");
            }

            var isAdmin = false;

            foreach (var admin in korisnici.KorisniciUloges)
            {
                if (admin.UlogaId == 2)
                {
                    isAdmin = true;
                }
            }

            if (isAdmin)
            {
                throw new UserException("Admin ne može biti izbrisan!");
            }

            korisnici.IsActive = false;

            await _context.SaveChangesAsync();

            return true;
        }

        public async Task<bool> EditUserByAdmin(int userId, KorisniciUpdateByAdminRequest request)
        {
            var korisniciAll = _context.Set<Database.Korisnici>();
            var korisnici = korisniciAll.Find(userId);

            if (korisnici == null)
            {
                throw new UserException("Korisnik ne postoji!");
            }

            var isAdmin = false;

            foreach(var admin in korisnici.KorisniciUloges)
            {
                if (admin.UlogaId == 2)
                {
                    isAdmin = true;
                }
            }

            if (isAdmin)
            {
                throw new UserException("Admin ne može biti editovan!");
            }

            if (string.IsNullOrEmpty(korisnici.Ime) || string.IsNullOrEmpty(korisnici.Prezime) || string.IsNullOrEmpty(korisnici.Email))
            {
                throw new UserException("Invalidni podaci!");
            }

            var emailInUse = korisniciAll.FirstOrDefault(x => x.Email.ToLower() == request.Email.ToLower());

            if (emailInUse != null)
            {
                throw new UserException("Email u upotrebi!");
            }

            korisnici.Ime = request.Ime;
            korisnici.Prezime = request.Prezime;
            korisnici.Email = request.Email;

            await _context.SaveChangesAsync();

            return true;
        }
    }
}
