using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model.RequestObjects
{
    public class IzvjestajiInsertRequest
    {
        public int BrojRezervacijeStaze { get; set; } = 0;
        public int UkupnaZaradaStaze { get; set; } = 0;
        public int UkupanBrojKorisnikaAplikacije { get; set; } = 0;
        public int UkupnaZaradaAplikacije { get; set; } = 0;
        public int KorisnikId { get; set; }
    }
}
