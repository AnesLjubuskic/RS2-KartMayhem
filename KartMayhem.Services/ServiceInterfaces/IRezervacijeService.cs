using KartMayhem.Model;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;

namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IRezervacijeService : IBaseCRUDService<Rezervacije, RezervacijeSearchRequest, RezervacijeUpsertRequest, RezervacijeUpsertRequest>
    {
        Task<bool> CancelReservation(int id);
        List<string> GetReservationTimeSlots(int stazaId, string datumRezervacije);
        Task<PagedResult<Rezervacije>> History(int userId);
        Task<PagedResult<Rezervacije>> GetCashReservations(int userId);
    }
}
