namespace KartMayhem.Model.Exception
{
    public class RezervacijeException : System.Exception
    {
        public string Title { get; set; }

        public RezervacijeException(string title, string message)
            : base(message)
        {
            Title = title;
        }

    }
}
