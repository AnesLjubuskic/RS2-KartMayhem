using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model.UserRequestObjects
{
    public class KorisniciUpdateRequest
    {
        public string? Ime { get; set; }

        public string? Prezime { get; set; }

        [Required(AllowEmptyStrings = false)]
        [EmailAddress()]
        public string? Email { get; set; }

        public string? Slika { get; set; }

    }
}
