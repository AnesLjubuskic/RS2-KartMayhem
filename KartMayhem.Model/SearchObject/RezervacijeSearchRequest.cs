using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model.SearchObject
{
    public class RezervacijeSearchRequest : BaseSearchObject
    {
        public string? NazivStaze { get; set; }

        public int? IdStaze { get; set; }
    }
}
