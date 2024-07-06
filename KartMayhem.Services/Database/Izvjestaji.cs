using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.Database
{
    public class Izvjestaji
    {
        public int Id { get; set; }
        public int BrojRezervacijeStaze { get; set; } = 0;
        public int UkupnaZaradaStaze { get; set; } = 0;
        public int UkupanBrojKorisnikaAplikacije { get; set; } = 0;
        public int UkupnaZaradaAplikacije { get; set; } = 0;
        public int KorisnikId { get; set; }
        public Korisnici Korisnik { get; set; }
        public DateTime VrijemeKreiranjaIzvjestaja { get; set; } = DateTime.Now;
    }
}
