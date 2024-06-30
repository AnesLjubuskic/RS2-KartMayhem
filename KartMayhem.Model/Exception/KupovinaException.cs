using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model.Exception
{
    public class KupovinaException : System.Exception
    {
        public KupovinaException(string message)
            : base(message)
        {
        }
    }
}
