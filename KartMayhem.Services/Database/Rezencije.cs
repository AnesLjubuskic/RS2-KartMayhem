namespace KartMayhem.Services.Database
{
    public class Rezencije
    {
        public int Id { get; set; }

        public string Komentar { get; set; }

        public int StazaId { get; set; }

        public Staze Staza { get; set; }
    }
}
