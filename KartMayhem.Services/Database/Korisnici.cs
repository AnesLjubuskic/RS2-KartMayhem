namespace KartMayhem.Services.Database
{
    public class Korisnici
    {
        public int Id { get; set; }

        public string Ime { get; set; } = null!;

        public string Prezime { get; set; } = null!;

        public string Email { get; set; }

        public string LozinkaHash { get; set; } = null!;

        public string LozinkaSalt { get; set; } = null!;

        public bool IsActive { get; set; }

        public int BrojRezervacija { get; set; }

        public string? Slika { get; set; }

        public virtual ICollection<KorisniciUloge> KorisniciUloges { get; } = new List<KorisniciUloge>();
        
        public virtual Nagrade? Nagrada { get; set; }
    }
}
