namespace KartMayhem.Services.Database
{
    public class Nagrade
    {
        public int Id { get; set; }

        public string NazivNagrade { get; set; }

        public ICollection<Korisnici> Korisnicis { get; } = new List<Korisnici>();
    }
}
