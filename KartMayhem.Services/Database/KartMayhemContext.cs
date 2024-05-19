using Microsoft.EntityFrameworkCore;

namespace KartMayhem.Services.Database
{
    public partial class KartMayhemContext : DbContext
    {
        public KartMayhemContext(DbContextOptions<KartMayhemContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Korisnici> Korisnicis { get; set; }

        public virtual DbSet<KorisniciUloge> KorisniciUloges { get; set; }

        public virtual DbSet<Uloge> Uloges { get; set; }

        public virtual DbSet<Nagrade> Nagrades { get; set; }
        
        public virtual DbSet<Opreme> Opremes { get; set; }

        public virtual DbSet<Rezencije> Rezencijes { get; set; }

        public virtual DbSet<Rezervacije> Rezervacijes { get; set; }

        public virtual DbSet<RezervacijeOpreme> RezervacijeOpremes { get; set; }

        public virtual DbSet<StatistikeStaze> StatistikeStaze { get; set; }

        public virtual DbSet<Staze> Stazes { get; set; }

        public virtual DbSet<Tezine> Tezines { get; set; }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);

    }
}
