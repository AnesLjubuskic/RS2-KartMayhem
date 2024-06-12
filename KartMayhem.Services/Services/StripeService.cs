using Microsoft.Extensions.Configuration;
using Stripe;

namespace KartMayhem.Services.Services
{
    public class StripeService
    {
        private readonly string apiKey;
        public StripeService(IConfiguration configuration)
        {
            apiKey = configuration["StripeSettings:ApiKey"] ?? Environment.GetEnvironmentVariable("STRIPE_API_KEY");
        }

        public string PlatiRezervaciju(int iznos, string opis)
        {
            StripeConfiguration.ApiKey = apiKey;
            var options = new PaymentIntentCreateOptions
            {
                Amount = iznos * 100,
                Currency = "EUR",
                Description = opis,
                //PaymentMethod = "pm_card_visa",
            };
            var service = new PaymentIntentService();
            var paymentIntent = service.Create(options);

            return paymentIntent.ClientSecret;
        }
    }
}
