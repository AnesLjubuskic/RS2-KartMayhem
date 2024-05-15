using KartMayhem.Model;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;

namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IStazeService : IBaseCRUDService<Staze, StazeSearchObject, StazeUpsertRequest, StazeUpsertRequest>
    {
        Task<bool> DeactivateTrack(int trackId);
    }
}
