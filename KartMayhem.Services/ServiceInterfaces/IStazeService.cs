using KartMayhem.Model;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;

namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IStazeService : IBaseCRUDService<Staze, StazeSearchObject, StazeUpsertRequest, StazeUpsertRequest>
    {
        Task<bool> DeactivateTrack(int trackId);

        Task<PagedResult<Model.Staze>> FavouriteTracks(int userId);

        Task<bool> MarkFavouriteTrack(int id, int userId);

        PagedResult<Model.Staze> StazeRecommenderSystem(int userId);
    }
}
