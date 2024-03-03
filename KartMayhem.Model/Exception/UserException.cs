using System;

namespace KartMayhem.Model.Exception
{
    public class UserException : System.Exception
    {
        public string Title { get; set; }

        public UserException(string title, string message) :
            base(message)
        {
            Title = title;
        }
    }
}
