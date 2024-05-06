using AutoMapper;
using KartMayhem.Model.UserRequestObjects;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity.Data;
using Microsoft.AspNetCore.Mvc;

namespace KartMayhem.Controllers
{
    [AllowAnonymous]
    [ApiController]
    [Route("[controller]")]
    public class AuthController : Controller
    {
        private readonly IAuthService _authService;
        public IMapper _mapper { get; set; }

        public AuthController(IAuthService authService, IMapper mapper) : base()
        {
            _mapper = mapper;
            _authService = authService;
        }
        [HttpPost("register")]
        public async Task<Model.Korisnici> Register([FromBody] KorisniciInsertRequest body)
        {
            var user = await _authService.Register(body);
            return user;
        }

        [HttpPost("login")]
        [AllowAnonymous]
        public async Task<Model.Korisnici> Login([FromBody] KorisniciLoginRequest body)
        {
            var user = await _authService.Login(body);
            return user;
        }

        [HttpPost("login/admin")]
        [AllowAnonymous]
        public async Task<Model.Korisnici> LoginAdmin([FromBody] KorisniciLoginRequest body)
        {
            var admin = await _authService.LoginAdmin(body);
            return admin;
        }
    }
}
