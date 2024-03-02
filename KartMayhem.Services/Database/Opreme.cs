namespace KartMayhem.Services.Database
{
    public class Opreme
    {
        public int Id { get; set; }

        public required string OpisOpreme { get; set; }

        public virtual ICollection<RezervacijeOpreme> RezervacijeOpremes { get; } = new List<RezervacijeOpreme>();
    }
}
