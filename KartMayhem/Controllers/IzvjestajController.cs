using KartMayhem.Model;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.ServiceInterfaces;
using KartMayhem.Services.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace KartMayhem.Controllers
{
    [Route("[controller]")]
    public class IzvjestajController : BaseCRUDController<Izvjestaji, BaseSearchObject, IzvjestajiInsertRequest, object>
    {
        protected IIzvjetajiService _izvjestajiService { get; set; }

        public IzvjestajController(ILogger<BaseController<Izvjestaji, BaseSearchObject>> logger, IIzvjetajiService service) : base(logger, service)
        {
            _izvjestajiService = service;
        }

        [HttpGet("izvjestaji")]
        public async Task<Izvjestaji> GetReservationTimeSlots(string godina, int? stazaId = null)
        {
            return await _izvjestajiService.GetIzvjestaj(stazaId, godina);
        }
    }
}
