using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model.RequestObjects
{
    public class RezervacijeUpsertRequest
    {
        public int BrojOsoba { get; set; }

        public int CijenaPoOsobi { get; set; }

        public string DayOfReservation { get; set; }

        public string TimeSlot { get; set; }

        public int KorisnikId { get; set; }

        public int StazaId { get; set; }

        public bool IsNagrada { get; set; }

        public bool IsGotovina { get; set; }
    }
}
