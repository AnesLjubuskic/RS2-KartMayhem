using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.Database
{
    public class Feedback
    {
        public int Id { get; set; }

        public string Komentar { get; set; }

        public int KorisnikId { get; set; }

        public Korisnici Korisnik { get; set; }
    }
}
