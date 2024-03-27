using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model
{
    public class Opreme
    {
        public required string OpisOpreme { get; set; }

        public virtual ICollection<RezervacijeOpreme> RezervacijeOpremes { get; } = new List<RezervacijeOpreme>();
    }
}
