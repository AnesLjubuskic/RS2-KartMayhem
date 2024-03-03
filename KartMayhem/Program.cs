using KartMayhem.Filters;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.Database;
using KartMayhem.Services.ServiceInterfaces;
using KartMayhem.Services.Services;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddTransient<ITezinaService,TezineService>();
builder.Services.AddTransient<IKorisniciService, KorisniciService>();
builder.Services.AddTransient<IBaseService<KartMayhem.Model.Tezine, BaseSearchObject>, BaseService<KartMayhem.Model.Tezine
    , KartMayhem.Services.Database.Tezine, BaseSearchObject>>();

builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();


var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<KartMayhemContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(ITezinaService));

builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    string? connection = app.Configuration.GetConnectionString("DefaultConnection");
    var dataContext = scope.ServiceProvider.GetRequiredService<KartMayhemContext>();
    dataContext.Database.Migrate();
}

app.Run();
