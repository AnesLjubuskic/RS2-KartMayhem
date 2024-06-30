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
            var encryptedApiKey = Environment.GetEnvironmentVariable("EncryptedApiKey") ?? "BWxWphrKGGW91TgQuoTsA6IwppwN8NpghaKbpFmEYCwhL6rBArX06EwcVTZed4g1fFXLJzVko20q9vI9em62gElM+LB/WFkaqQ8uv76463U=";
            var encryptionKey = Environment.GetEnvironmentVariable("EncryptionKey") ?? "SSODKAX9832Q01AA";
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
