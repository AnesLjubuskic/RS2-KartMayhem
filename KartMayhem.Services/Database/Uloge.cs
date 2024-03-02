namespace KartMayhem.Services.Database
{
    public class Uloge
    {
        public int Id { get; set; }

        public string Naziv { get; set; } = null!;

        public virtual ICollection<KorisniciUloge> KorisniciUloges { get; } = new List<KorisniciUloge>();
    }
}
