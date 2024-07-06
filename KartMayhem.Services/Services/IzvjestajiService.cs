using AutoMapper;
using KartMayhem.Model;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.Database;
using KartMayhem.Services.ServiceInterfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.Services
{
    public class IzvjestajiService : BaseCRUDService<Model.Izvjestaji, Database.Izvjestaji, BaseSearchObject, IzvjestajiInsertRequest, object>, IIzvjetajiService
    {
        public IzvjestajiService(IB190060_KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public Task<Model.Izvjestaji> GetIzvjestaj(int? stazaId, string godina)
        {
            var izvjestaj = new Model.Izvjestaji();
            var rezevacijaStaze = _context.Rezervacijes.Where(x => x.StazaId == stazaId && !x.isCancelled && x.DayOfReservation.Contains(godina)).ToList();
            var sveRezervacijePoGodini = _context.Rezervacijes.Where(x =>  !x.isCancelled && x.DayOfReservation.Contains(godina)).ToList();
            var sveRezervacijeUkupno = _context.Rezervacijes.Where(x => !x.isCancelled).ToList();
            var brojKorisnika = _context.Korisnicis.Where(x => x.IsActive).ToList();

            if (rezevacijaStaze == null || !rezevacijaStaze.Any())
            {
                izvjestaj.BrojRezervacijeStaze = 0;
                izvjestaj.UkupnaZaradaStaze = 0;
            }
            else
            {
                var brojRezervacijeStaze = rezevacijaStaze.Count();
                var ukupnaZaradaStaze = rezevacijaStaze.Sum(x => x.CijenaRezervacije);
                izvjestaj.BrojRezervacijeStaze = brojRezervacijeStaze;
                izvjestaj.UkupnaZaradaStaze = ukupnaZaradaStaze;
            }

            if (stazaId == null)
            {
                izvjestaj.BrojRezervacijeStaze = sveRezervacijePoGodini.Count();
                izvjestaj.UkupnaZaradaStaze = sveRezervacijePoGodini.Sum(x => x.CijenaRezervacije);
            }

            if (brojKorisnika == null || !brojKorisnika.Any())
            {
                izvjestaj.UkupanBrojKorisnikaAplikacije = 0;
            }
            else
            {
                var ukupanBrojKorisnikaAplikacije = brojKorisnika.Count();
                izvjestaj.UkupanBrojKorisnikaAplikacije = ukupanBrojKorisnikaAplikacije;
            }

            if (sveRezervacijeUkupno == null || !sveRezervacijeUkupno.Any())
            {
                izvjestaj.UkupnaZaradaAplikacije = 0;
            }
            else
            {
                var ukupnaZaradaAplikacije = sveRezervacijeUkupno.Sum(x => x.CijenaRezervacije);
                izvjestaj.UkupnaZaradaAplikacije = ukupnaZaradaAplikacije;
            }

            return Task.FromResult(izvjestaj);
        }
    }
}
