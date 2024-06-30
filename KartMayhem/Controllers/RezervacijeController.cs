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

        [HttpPut("cancel/{id}")]
        public async Task<bool> CancelReservation(int Id)
        {
            return await _rezervacijeService.CancelReservation(Id);
        }

        [HttpGet("timeSlots")]
        public List<string> GetReservationTimeSlots(int stazaId, string datumRezervacije)
        {
            return _rezervacijeService.GetReservationTimeSlots(stazaId, datumRezervacije);
        }

        [HttpGet("history")]
        public async Task<PagedResult<Rezervacije>> History(int userId)
        {
            return await _rezervacijeService.History(userId);
        }

        [HttpGet("cashReservations")]
        public async Task<PagedResult<Rezervacije>> CashReservations(int userId)
        {
            return await _rezervacijeService.GetCashReservations(userId);
        }
    }
}
