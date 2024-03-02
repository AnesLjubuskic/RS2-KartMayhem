namespace KartMayhem.Services.Database
{
    public class StatistikeStaze
    {
        public int Id { get; set; }

        public int BrojRezervacija { get; set; }

        public int UkupnaZarada { get; set; }
        
        public int StazaId { get; set; }

        public Staze Staza { get; set; } = null!;
    }
}
