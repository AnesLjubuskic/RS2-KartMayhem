using KartMayhem.Model;
using KartMayhem.Model.SearchObject;
using KartMayhem.Model.UserRequestObjects;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity.Data;
using Microsoft.AspNetCore.Mvc;

namespace KartMayhem.Controllers
{
    [Route("[controller]")]
    public class KorisniciController : BaseCRUDController<Model.Korisnici, BaseSearchObject, object, object>
    {

        protected IKorisniciService _korisniciService { get; set; }

        public KorisniciController(ILogger<BaseController<Korisnici, BaseSearchObject>> logger, IKorisniciService service) 
            : base(logger, service)
        {            
            _korisniciService = service;
        }

        [HttpPost("login")]
        public async Task<Model.Korisnici> Login([FromBody] KorisniciLoginRequest body)
        {
            return await _korisniciService.Login(body);
        }

    }
}
