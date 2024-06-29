using KartMayhem.Model.UniqueGetRequests;

namespace KartMayhem.Model
{
    public class Rezervacije
    {
        public int Id { get; set; }

        public int CijenaRezervacije { get; set; }

        public int BrojOsoba { get; set; }

        public string ImeStaze { get; set; }

        public string DayOfReservation { get; set; }

        public string TimeSlot { get; set; }

        public Korisnici Korisnik { get; set; }

        public Staze Staza { get; set; }
    }
}
