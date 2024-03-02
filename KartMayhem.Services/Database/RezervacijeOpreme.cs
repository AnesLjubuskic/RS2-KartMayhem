namespace KartMayhem.Services.Database
{
    public class RezervacijeOpreme
    {
        public int Id { get; set; }

        public int RezervacijaId { get; set; }

        public int OpremaId { get; set; }

        public virtual Rezervacije Rezervacija { get; set; } = null!;

        public virtual Opreme Oprema { get; set; } = null!;
    }
}
