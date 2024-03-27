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
        public int CijenaRezervacije { get; set; }

        public int BrojOsoba { get; set; }

        public DateTime DayOfReservation { get; set; } // Povuci sve rezervacije po ovom danu pa izvlaci time slotove iz start time-a

        public DateTime TimeSlot { get; set; }


        [Required(ErrorMessage = "Id korisnika je obavezan!")]
        public int KorisnikId { get; set; }

        [Required(ErrorMessage = "Id staze je obavezna!")]
        public int StazaId { get; set; }

        public virtual ICollection<RezervacijeOpreme> RezervacijeOpremes { get; } = new List<RezervacijeOpreme>();
    }
}
