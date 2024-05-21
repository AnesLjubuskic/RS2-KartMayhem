using KartMayhem.Model;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using KartMayhem.Model.UserRequestObjects;
using KartMayhem.Services.ServiceInterfaces;
using KartMayhem.Services.Services;
using Microsoft.AspNetCore.Mvc;

namespace KartMayhem.Controllers
{
    [Route("[controller]")]
    public class RezervacijeController : BaseCRUDController<Rezervacije, RezervacijeSearchRequest, RezervacijeUpsertRequest, RezervacijeUpsertRequest>
    {
        protected IRezervacijeService _rezervacijeService { get; set; }

        public RezervacijeController(ILogger<BaseController<Rezervacije, RezervacijeSearchRequest>> logger, IRezervacijeService service) : base(logger, service)
        {
            _rezervacijeService = service;
        }

        [HttpPut("cancel")]
        public async Task<bool> Login(int Id)
        {
            return await _rezervacijeService.CancelReservation(Id);
        }
    }
}
