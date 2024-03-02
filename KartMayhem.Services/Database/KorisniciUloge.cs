namespace KartMayhem.Services.Database
{
    public class KorisniciUloge
    {
        public int Id { get; set; }

        public int KorisnikId { get; set; }

        public int UlogaId { get; set; }

        public virtual Korisnici Korisnik { get; set; } = null!;

        public virtual Uloge Uloga { get; set; } = null!;
    }
}
