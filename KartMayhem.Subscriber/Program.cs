using EasyNetQ;
using KartMayhem.Model;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.DependencyInjection;
using KartMayhem.Subscriber;

static IHostBuilder CreateHostBuilder() =>
    Host.CreateDefaultBuilder().ConfigureServices((hostContext, services) =>
    {
        services.AddHostedService<RabbitMQHostedService>();
    });

CreateHostBuilder().Build().Run();
public class RabbitMQHostedService : IHostedService
{
    private IBus _bus;
    private EmailService _service;
    private EmailSendGridService _sendGridService;


    public RabbitMQHostedService()
    {
        _service = new EmailService();
        _sendGridService = new EmailSendGridService();
        _bus = RabbitHutch.CreateBus("host=localhost");
        while (true)
        {
            try
            {
                _bus.PubSub.Subscribe<RezervacijeMail>("Nova_Rezervacija", HandleTextMessage);
                Console.WriteLine("Subscribe successful,listening for messages.");
                break;
            }
            catch
            {
                Console.WriteLine("Subscribe failed,retrying...");
                Thread.Sleep(5000);
            }
        }
    }
    public Task StartAsync(CancellationToken cancellationToken)
    {
        return Task.CompletedTask;
    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        _bus.Dispose();
        //console log "Dispoing"
        Console.WriteLine("Stop async");
        return Task.CompletedTask;
    }
    private Task HandleTextMessage(RezervacijeMail entity)
    {
        Console.WriteLine($"Rezervacija: {entity?.ImeStaze}, Email: {entity.Email}");
        _sendGridService.Send("Nova Rezervacija", $"Rezervisali ste {entity.ImeStaze}.", entity.Email, entity.Email);
        _service.SendEmailAsync(entity.Email, "Nova rezervacija na Kart Mayhemu!", $"Rezervisali ste termin na {entity.ImeStaze}.");
        return Task.CompletedTask;
    }
}