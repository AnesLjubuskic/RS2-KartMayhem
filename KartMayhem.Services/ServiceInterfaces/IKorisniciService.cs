using KartMayhem.Model;
using KartMayhem.Model.SearchObject;
using KartMayhem.Model.UserRequestObjects;

namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IKorisniciService : IBaseService<Model.Korisnici, Model.SearchObject.BaseSearchObject>
    {
        public Task<List<Model.Korisnici>> TopUsers();
    }
}
