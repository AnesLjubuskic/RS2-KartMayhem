namespace KartMayhem.Services.Database
{
    public class Rezervacije
    {
        public int Id {get; set; }

        public int CijenaRezervacije { get; set; }

        public string ImeStaze { get; set; }

        public int BrojOsoba { get; set; }

        public string DayOfReservation { get; set; }

        public string TimeSlot { get; set; }

        public int KorisnikId { get; set; }

        public Korisnici Korisnik { get; set; }

        public int StazaId { get; set; }

        public Staze Staza { get; set; }

        public bool isCancelled { get; set; } = false;

        public virtual ICollection<RezervacijeOpreme> RezervacijeOpremes { get; } = new List<RezervacijeOpreme>();
    }
}
