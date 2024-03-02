namespace KartMayhem.Services.Database
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

        public int TezinaId { get; set; }

        public Tezine Tezina { get; set; }

        public ICollection<Rezervacije> Rezervacijes { get; set; } = new List<Rezervacije>();

        public ICollection<Rezencije> Rezencijes { get; } = new List<Rezencije>();
    }
}
