using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model.UserRequestObjects
{
    public class KorisniciInsertRequest
    {
        public string Ime { get; set; }

        public string Prezime { get; set; }

        public string? Slika { get; set; }

        public string Email { get; set; }

        public string Lozinka { get; set; }

        public List<int>? Uloge { get; set; } = new List<int>();
    }
}
