using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model.UserRequestObjects
{
    public class KorisniciLoginRequest
    {
        [Required]
        [MinLength(6, ErrorMessage = "Neispravan format e-pošte")]
        public string Email { get; set; }

        [Required]
        [MinLength(6, ErrorMessage = "Lozinka mora sadržavati najmanje 6 karaktera!")]
        public string Lozinka { get; set; }
    }
}
