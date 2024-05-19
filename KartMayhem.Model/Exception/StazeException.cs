using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Model.Exception
{
    public class StazeException : System.Exception
    {
        public string Title { get; set; }
        public StazeException(string title, string message)
            : base(message)
        {
            Title = title;
        }
    }
}
