using Azure.Core;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text.Encodings.Web;
using System.Text;
using KartMayhem.Model.UserRequestObjects;
using Microsoft.AspNetCore.Identity.Data;

namespace KartMayhem
{
    public class BasicAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
    {
        IAuthService _authService;
        public BasicAuthenticationHandler(IAuthService authService, IOptionsMonitor<AuthenticationSchemeOptions> options, ILoggerFactory logger, UrlEncoder encoder, ISystemClock clock) : base(options, logger, encoder, clock)
        {
            _authService = authService;
        }

        protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
        {
            if (!Request.Headers.ContainsKey("Authorization"))
            {
                return AuthenticateResult.Fail("Missing authorization header");
            }
            Model.Korisnici korisnik;
            try
            {
                var authHeader = AuthenticationHeaderValue.Parse(Request.Headers["Authorization"]);
                var credentialBytes = Convert.FromBase64String(authHeader.Parameter);
                var credentials = Encoding.UTF8.GetString(credentialBytes).Split(':');
                var email = credentials[0];
                var password = credentials[1];

                KorisniciLoginRequest request = new KorisniciLoginRequest
                {
                    Lozinka = password,
                    Email = email
                };

                korisnik = await _authService.Login(request);
            }
            catch
            {
                return AuthenticateResult.Fail("Netacno korisnicko ime ili lozinka");
            }
            if (korisnik == null)
                return AuthenticateResult.Fail("Netacno korisnicko ime ili lozinka");

            var claims = new List<Claim> {
                new Claim(ClaimTypes.Email, korisnik.Email),
                new Claim(ClaimTypes.Name, $"{korisnik.Ime} {korisnik.Prezime}"),
            };

            foreach (var uloga in korisnik.KorisniciUloges)
            {
                claims.Add(new Claim(ClaimTypes.Role, uloga.Uloga.Naziv));
            }

            var identity = new ClaimsIdentity(claims, Scheme.Name);
            var principal = new ClaimsPrincipal(identity);
            var ticket = new AuthenticationTicket(principal, Scheme.Name);
            return AuthenticateResult.Success(ticket);
        }
    } 
}

