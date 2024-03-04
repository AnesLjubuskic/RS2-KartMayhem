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
        [Required(AllowEmptyStrings = false)]
        public string Ime { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Prezime { get; set; }

        [Required(AllowEmptyStrings = false)]
        [EmailAddress()]
        public string Email { get; set; }

        [Required]
        [MinLength(6, ErrorMessage = "Lozinka mora sadržavati najmanje 6 karaktera!")]
        public string Lozinka { get; set; }

        public List<int>? Uloge { get; set; } = new List<int>();
    }
}
