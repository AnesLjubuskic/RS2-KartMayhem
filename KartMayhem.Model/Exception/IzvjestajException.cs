using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model.Exception
{
    public class IzvjestajException : System.Exception
    {
        public IzvjestajException(string message)
            : base(message)
        {
        }
    }
}
