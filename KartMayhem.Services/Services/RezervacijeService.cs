using AutoMapper;
using KartMayhem.Model;
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
        private readonly IEmailSenderService _emailSenderService;

        public RezervacijeService(KartMayhemContext context, IMapper mapper, IEmailSenderService emailSenderService) : base(context, mapper)
        {
            _emailSenderService = emailSenderService;
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

            if (insert.CijenaPoOsobi < 1 || insert.CijenaPoOsobi > 1000)
            {
                throw new RezervacijeException("Broj osoba nije validan!");
            }

            if (string.IsNullOrWhiteSpace(insert.DayOfReservation))
            {
                throw new RezervacijeException("Datum rezervacije nije primljen!");
            }

            if (string.IsNullOrWhiteSpace(insert.TimeSlot))
            {
                throw new RezervacijeException("Termin nije primljen!");
            }

            var user = _context.Korisnicis.Find(insert.KorisnikId);

            if (user == null)
            {
                throw new RezervacijeException("Osoba nije pronadjena!");
            }

            return base.ValidationInsert(insert);
        }

        public override Task BeforeInsert(Database.Rezervacije entity, RezervacijeUpsertRequest insert)
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

            var timeSlots = GetReservationTimeSlots(insert.StazaId, insert.DayOfReservation);

            if (timeSlots.Count == 0 || !timeSlots.Contains(insert.TimeSlot))
            {
                throw new RezervacijeException("Termin nije dostupan!");
            }

            entity.ImeStaze = staza.NazivStaze;

            entity.CijenaRezervacije = insert.BrojOsoba * insert.CijenaPoOsobi;

            return base.BeforeInsert(entity, insert);
        }

        public override Task AfterInsert(Database.Rezervacije entity, RezervacijeUpsertRequest insert)
        {
            var user = _context.Korisnicis.Find(insert.KorisnikId);

            if (user != null) 
            { 
                Model.RezervacijeMail rezervacijeMail = new Model.RezervacijeMail
                {
                    Email = user.Email,
                    ImeStaze = entity.ImeStaze,
                };

                _emailSenderService.SendingObject(rezervacijeMail);
            }

            return base.AfterInsert(entity, insert);
        }

        public override IQueryable<Database.Rezervacije> AddFilter(IQueryable<Database.Rezervacije> query, RezervacijeSearchRequest? search = null)
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
        public List<string> GetReservationTimeSlots(int stazaId, string datumRezervacije)
        {
            var reservations = _context.Rezervacijes
                .Where(x => x.DayOfReservation == datumRezervacije
                       && x.StazaId == stazaId);

            List<string> allTimeSlots = ReservationSlots.getReservationSlots();
            List<string> returnSlots = new List<string> { };

            foreach (var timeSlot in allTimeSlots)
            {
                if (!reservations.Any(x => x.TimeSlot == timeSlot && !x.isCancelled))
                    returnSlots.Add(timeSlot);
            };

            return returnSlots;
        }
    }
}
