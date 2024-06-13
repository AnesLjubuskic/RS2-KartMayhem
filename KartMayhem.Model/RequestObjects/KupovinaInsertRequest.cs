using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model.RequestObjects
{
    public class KupovinaInsertRequest
    {
        [Required]
        public int Cijena { get; set; }

        [Required]
        public int? KorisnikId { get; set; }

        [Required]
        public int? StazaId { get; set; }
    }
}
