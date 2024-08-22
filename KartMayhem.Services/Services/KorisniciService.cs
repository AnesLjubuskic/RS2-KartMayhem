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
    public class KorisniciService : BaseCRUDService<Model.Korisnici, Database.Korisnici, Model.SearchObject.KorisniciSearchObject, object, KorisniciUpdateRequest>, IKorisniciService
    {
        public KorisniciService(IB190060_KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public async Task<bool> CancelRewardUser(int userId)
        {
            var korisnici = _context.Set<Database.Korisnici>()
                           .FirstOrDefault(x => x.Id == userId);

            if (korisnici == null)
            {
                throw new UserException("Korisnik ne postoji!");
            }

            if (!korisnici.IsNagrada)
            {
                throw new UserException("Korisnik ne posjeduje nagradu!");
            }

            korisnici.IsNagrada = false;

            await _context.SaveChangesAsync();

            return true;
        }

        public async Task<bool> RewardUser(int userId)
        {
            var korisnici = _context.Set<Database.Korisnici>()
                .FirstOrDefault(x => x.Id == userId);

            if (korisnici == null)
            {
                throw new UserException("Korisnik ne postoji!");
            }

            if (korisnici.IsNagrada)
            {
                throw new UserException("Korisnik posjeduje nagradu!");
            }

            korisnici.IsNagrada = true;

            await _context.SaveChangesAsync();

            return true;
        }

        public async Task<List<Model.Korisnici>> TopUsers()
        {
            var korisnici = _context.Set<Database.Korisnici>();
            var rezervacije = _context.Set<Database.Rezervacije>();

            var listaKorisnika = new List<Database.Korisnici>();

            foreach(var korisnik in korisnici)
            {
                var korisnikCount = 0;
                foreach(var rezervacija in rezervacije)
                {
                    if(rezervacija.KorisnikId == korisnik.Id)
                    {
                        korisnikCount++;
                    }
                }
                korisnik.BrojRezervacija = korisnikCount;
                listaKorisnika.Add(korisnik);
            }

            var listaKorisnikaDto = listaKorisnika.OrderByDescending(x => x.BrojRezervacija).Take(5);
            var korisniciDto = _mapper.Map<List<Model.Korisnici>>(listaKorisnikaDto);

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

            if (string.IsNullOrWhiteSpace(request.Ime) || string.IsNullOrWhiteSpace(request.Prezime) || string.IsNullOrWhiteSpace(request.Email))
            {
                throw new UserException("Invalidni podaci!");
            }

            var emailInUse = korisniciAll.FirstOrDefault(x => x.Email.ToLower() == request.Email.ToLower());

            if (emailInUse != null && korisnici.Email.ToLower() != request.Email.ToLower())
            {
                throw new UserException("Email u upotrebi!");
            }

            korisnici.Ime = request.Ime;
            korisnici.Prezime = request.Prezime;
            korisnici.Email = request.Email;

            await _context.SaveChangesAsync();

            return true;
        }

        public async Task<bool> EditUser(int userId, KorisniciUpdateRequest request)
        {
            var korisniciAll = _context.Set<Database.Korisnici>();
            var korisnici = korisniciAll.Find(userId);

            if (korisnici == null)
            {
                throw new UserException("Korisnik ne postoji!");
            }

            if (string.IsNullOrWhiteSpace(request.Ime) || string.IsNullOrWhiteSpace(request.Prezime) || string.IsNullOrWhiteSpace(request.Email))
            {
                throw new UserException("Invalidni podaci!");
            }

            if (!string.IsNullOrWhiteSpace(request.Slika))
            {
                korisnici.Slika = request.Slika;
            }

            korisnici.Ime = request.Ime;
            korisnici.Prezime = request.Prezime;
            korisnici.Email = request.Email;

            await _context.SaveChangesAsync();

            return true;
        }
    }
}
