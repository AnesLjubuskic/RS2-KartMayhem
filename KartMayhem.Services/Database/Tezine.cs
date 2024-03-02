namespace KartMayhem.Services.Database
{
    public class Tezine
    {
        public int Id { get; set; }

        public string Naziv { get; set; }

        public ICollection<Staze> Staze { get; } = new List<Staze>();

    }
}
