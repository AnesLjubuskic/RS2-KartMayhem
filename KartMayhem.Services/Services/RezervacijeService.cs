using AutoMapper;
using KartMayhem.Model.Exception;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.Database;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.Services
{
    public class RezervacijeService : BaseCRUDService<Model.Rezervacije, Database.Rezervacije, RezervacijeSearchRequest, RezervacijeUpsertRequest, RezervacijeUpsertRequest>, IRezervacijeService
    {
        public RezervacijeService(KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override Task ValidationInsert(RezervacijeUpsertRequest insert)
        {
            if (insert == null)
            {
                throw new RezervacijeException("Rezervacija ne posjeduje vrijednost!");
            }

            if (insert.BrojOsoba < 1 || insert.BrojOsoba > 10)
            {
                throw new RezervacijeException("Broj osoba nije validan!");
            }

            if (insert.CijenaRezervacije < 1 || insert.CijenaRezervacije > 9999)
            {
                throw new RezervacijeException("Cijena rezervacije nije validna!");
            }

            var user = _context.Korisnicis.Find(insert.KorisnikId);

            if (user == null)
            {
                throw new RezervacijeException("Osoba nije pronadjena!");
            }

            return base.ValidationInsert(insert);
        }

        public override Task BeforeInsert(Rezervacije entity, RezervacijeUpsertRequest insert)
        {
            var staza = _context.Stazes.Find(insert.StazaId);

            if (staza == null)
            {
                throw new RezervacijeException("Staza nije pronadjena!");
            }
            else if (!staza.IsActive)
            {
                throw new RezervacijeException("Staza nije aktivna!");
            }

            entity.ImeStaze = staza.NazivStaze;

            return base.BeforeInsert(entity, insert);
        }

        public override IQueryable<Rezervacije> AddFilter(IQueryable<Rezervacije> query, RezervacijeSearchRequest? search = null)
        {
            var filter = base.AddFilter(query, search);

            filter = filter.Where(x => !x.isCancelled);

            if (search != null && !string.IsNullOrEmpty(search.NazivStaze))
            {
                filter = filter.Where(x => x.ImeStaze.ToLower() ==  search.NazivStaze.ToLower());
            }

            if (search != null && search.IdStaze != null)
            {
                filter = filter.Where(x => x.StazaId == search.IdStaze);
            }

            return filter;
        }

        public async Task<bool> CancelReservation(int id)
        {
            var rezervacija = _context.Rezervacijes.Find(id);
            if (rezervacija == null)
            {
                throw new RezervacijeException("Rezervacija ne postoji!");
            }

            rezervacija.isCancelled = true;
            await _context.SaveChangesAsync();

            return true;
        }
    }
}
