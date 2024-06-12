using KartMayhem.Model.UniqueGetRequests;

namespace KartMayhem.Model
{
    public class Rezervacije
    {
        public int Id { get; set; }

        public int CijenaRezervacije { get; set; }

        public int BrojOsoba { get; set; }

        public string ImeStaze { get; set; }

        public string DayOfReservation { get; set; } // Povuci sve rezervacije po ovom danu pa izvlaci time slotove iz start time-a

        public string TimeSlot { get; set; }

        public Korisnici Korisnik { get; set; }

        public StazeForRezervacije Staza { get; set; }

        public virtual ICollection<RezervacijeOpreme> RezervacijeOpremes { get; } = new List<RezervacijeOpreme>();
    }
}
