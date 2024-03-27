using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model.UniqueGetRequests
{
    public class StazeForRezervacije
    {
        public int Id { get; set; }

        public string NazivStaze { get; set; }

        public string OpisStaze { get; set; }

        public int CijenaPoOsobi { get; set; }

        public double DuzinaStaze { get; set; }

        public int BrojKrugova { get; set; }

        public int MaxBrojOsoba { get; set; }

        public Tezine Tezina { get; set; }
    }
}
