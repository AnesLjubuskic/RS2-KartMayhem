using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.Database
{
    public class KorisniciStaze
    {
        public int Id { get; set; }

        public int KorisniciId { get; set; }

        public int StazeId { get; set; }

        public virtual Staze Staze { get; set; } = null!;

        public virtual Korisnici Korisnici { get; set; } = null!;
    }
}
