using KartMayhem.Model;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;

namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IStazeService : IBaseCRUDService<Staze, BaseSearchObject, StazeInsertRequest, object>
    {
    }
}
