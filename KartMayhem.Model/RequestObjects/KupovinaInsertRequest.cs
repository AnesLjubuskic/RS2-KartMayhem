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
        public int? Cijena { get; set; }

        public int? KorisnikId { get; set; }

        public int? StazaId { get; set; }
    }
}
