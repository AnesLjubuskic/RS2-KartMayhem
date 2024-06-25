using SendGrid;
using SendGrid.Helpers.Mail;


namespace KartMayhem.Subscriber
{
    public class EmailSendGridService
    {
        private readonly string _apiKey;
        private readonly SendGridClient _client;
        private readonly EmailAddress _fromAddress;

        public EmailSendGridService()
        {
            var encryptedApiKey = Environment.GetEnvironmentVariable("EncryptedApiKey") ?? "Q1vV48KBIqHUaZENVYLno8tOypbKSyUeCEl06219o/0kAZGJapGPnJ37nCqq8prs7qe0GlsDI6Thjc7TT17IG9P9YdVM7NR18JX49XmO/G4=";
            var encryptionKey = Environment.GetEnvironmentVariable("EncryptionKey") ?? "73Gh30kxP4j7W2nX5Rf8T3vZ20QqM1uY";
            _apiKey = EncryptionHelper.DecryptString(encryptedApiKey, encryptionKey);
            _client = new SendGridClient(_apiKey);
            _fromAddress = new EmailAddress("kartingmayhem@outlook.com", "Karting Mayhem");
        }
        public async Task Send(string subject, string body, string toAddress, string name)
        {
            var to = new EmailAddress(toAddress, name);
            var plainTextContent = "and easy to do anywhere, even with C#";
            var msg = MailHelper.CreateSingleEmail(_fromAddress, to, subject, plainTextContent, body);
            await _client.SendEmailAsync(msg).ConfigureAwait(false);
        }
    }
}
