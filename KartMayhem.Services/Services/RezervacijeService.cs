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
    public class RezervacijeService : BaseCRUDService<Model.Rezervacije, Database.Rezervacije, BaseSearchObject, RezervacijeUpsertRequest, RezervacijeUpsertRequest>, IRezervacijeService
    {
        public RezervacijeService(KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override Task BeforeInsert(Rezervacije entity, RezervacijeUpsertRequest insert)
        {
            if (insert.BrojOsoba < 1 || insert.BrojOsoba > 10)
            {
                throw new RezervacijeException(problem, "Broj osoba nije validan!");
            }

            var user = _context.Korisnicis.Find(insert.KorisnikId);
            if (user == null)
            {
                throw new RezervacijeException(problem, "Osoba nije pronadjena!");
            }

            var staza = _context.Stazes.Find(insert.StazaId);
            if (staza == null)
            {
                throw new RezervacijeException(problem, "Staza nije pronadjena!");
            }

            return base.BeforeInsert(entity, insert);
        }

        public override IQueryable<Rezervacije> AddFilter(IQueryable<Rezervacije> query, BaseSearchObject? search = null)
        {
            var filter = base.AddFilter(query, search);

            filter = filter.Where(x => !x.isCancelled);

            return filter;
        }

        public async Task<bool> CancelReservation(int id)
        {
            var rezervacija = _context.Rezervacijes.Find(id);
            if (rezervacija == null)
            {
                throw new RezervacijeException(problem, "Rezervacija ne postoji!");
            }

            rezervacija.isCancelled = true;
            await _context.SaveChangesAsync();

            return true;
        }
    }
}
