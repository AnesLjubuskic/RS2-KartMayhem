namespace KartMayhem.Model
{
    public class KorisniciUloge
    {
        public int Id { get; set; }

        public int? KorisnikId { get; set; }

        public int? UlogaId { get; set; }

        public virtual Uloge Uloga { get; set; } 
    }
}
