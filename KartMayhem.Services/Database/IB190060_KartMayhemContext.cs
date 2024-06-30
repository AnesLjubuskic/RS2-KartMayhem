using Microsoft.EntityFrameworkCore;

namespace KartMayhem.Services.Database
{
    public partial class IB190060_KartMayhemContext : DbContext
    {
        public IB190060_KartMayhemContext()
        {
        }

        public IB190060_KartMayhemContext(DbContextOptions<IB190060_KartMayhemContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Korisnici> Korisnicis { get; set; }

        public virtual DbSet<Kupovina> Kupovinas { get; set; }

        public virtual DbSet<KorisniciUloge> KorisniciUloges { get; set; }

        public virtual DbSet<KorisniciStaze> KorisniciStazes { get; set; }

        public virtual DbSet<Uloge> Uloges { get; set; }

        public virtual DbSet<Nagrade> Nagrades { get; set; }
        
        public virtual DbSet<Rezencije> Rezencijes { get; set; }

        public virtual DbSet<Rezervacije> Rezervacijes { get; set; }

        public virtual DbSet<StatistikeStaze> StatistikeStaze { get; set; }

        public virtual DbSet<Staze> Stazes { get; set; }

        public virtual DbSet<Tezine> Tezines { get; set; }

        public virtual DbSet<Feedback> Feedbacks { get; set; }

        public virtual DbSet<Gradovi> Gradovis { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=DESKTOP-8K5VMBF\\MSSQLSERVER_OLAP;Database=KartMayhem;Trusted_Connection=true;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
