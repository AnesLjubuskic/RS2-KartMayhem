namespace KartMayhem.Model
{
    public class Staze
    {
        public int Id { get; set; }

        public string NazivStaze { get; set; }

        public string OpisStaze { get; set; }

        public int CijenaPoOsobi { get; set; }

        public double DuzinaStaze { get; set; }

        public int BrojKrugova { get; set; }

        public int MaxBrojOsoba { get; set; }

        public Tezine Tezina { get; set; }

        public int? BrojRezervacija { get; set; }

        public byte[]? Slika { get; set; }

        public bool IsActive { get; set; }

        public ICollection<Rezencije> Rezencijes { get; } = new List<Rezencije>();
    }
}
