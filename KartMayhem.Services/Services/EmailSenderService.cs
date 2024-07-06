using EasyNetQ;
using KartMayhem.Model;
using KartMayhem.Services.ServiceInterfaces;

namespace KartMayhem.Services.Services
{
    public class EmailSenderService : IEmailSenderService
    {
        private readonly string hostname = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitMQ";
        private readonly string username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest";
        private readonly string password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest";
        private readonly string virtualHost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

        public void SendingObject(RezervacijeMail obj)
        {
            using var bus = RabbitHutch.CreateBus($"host={hostname};virtualHost={virtualHost};username={username};password={password}");

            bus.PubSub.Publish(obj);
        }
    }
}
