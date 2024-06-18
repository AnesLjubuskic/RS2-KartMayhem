using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model.SearchObject
{
    public class StazeSearchObject : BaseSearchObject
    {
        public string? NazivStaze { get; set; }
        public int[]? TezineId { get; set; }
        public int? UserId { get; set; }
    }
}
