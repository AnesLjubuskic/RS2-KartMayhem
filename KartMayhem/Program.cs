using KartMayhem;
using KartMayhem.Filters;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.Database;
using KartMayhem.Services.ServiceInterfaces;
using KartMayhem.Services.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddTransient<ITezinaService,TezineService>();
builder.Services.AddTransient<IAuthService,AuthService>();
builder.Services.AddTransient<IKorisniciService, KorisniciService>();
builder.Services.AddTransient<IStazeService, StazeService>();
builder.Services.AddTransient<IRezencijeService, RezencijeService>();
builder.Services.AddTransient<IRezervacijeService, RezervacijeService>();
builder.Services.AddTransient<IBaseService<KartMayhem.Model.Tezine, BaseSearchObject>, BaseService<KartMayhem.Model.Tezine
    , KartMayhem.Services.Database.Tezine, BaseSearchObject>>();

builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});

builder.Services.AddControllers();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new OpenApiSecurityScheme()
    {
        Type = SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference{Type = ReferenceType.SecurityScheme, Id = "basicAuth"}
            },
            new string[]{}
    } });

});

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<KartMayhemContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(ITezinaService));

builder.Services.AddSwaggerGen();

builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    string? connection = app.Configuration.GetConnectionString("DefaultConnection");
    var dataContext = scope.ServiceProvider.GetRequiredService<KartMayhemContext>();
    dataContext.Database.Migrate();
}

app.Run();
