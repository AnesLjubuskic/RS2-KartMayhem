using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model
{
    public class Kupovina
    {
        public int Id { get; set; }
        public int Cijena { get; set; }
        public DateTime? DatumKupovine { get; set; }
        public string? PaymentIntentId { get; set; }
        public bool? Placena { get; set; }
        public int? KorisnikId { get; set; }
        public virtual Korisnici? Korisnik { get; set; }
        public int? StazaId { get; set; }
        public virtual Staze? Staze { get; set; }
    }
}
