﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model.UserRequestObjects
{
    public class KorisniciUpdateByAdminRequest
    {
        public string Ime { get; set; }

        public string Prezime { get; set; }

        [Required(AllowEmptyStrings = false)]
        [EmailAddress()]
        public string Email { get; set; }
    }
}
