using KartMayhem.Model;
using KartMayhem.Model.SearchObject;
using KartMayhem.Model.UserRequestObjects;

namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IKorisniciService : IBaseCRUDService<Korisnici, BaseSearchObject, KorisniciInsertRequest, object>
    {
        public Task<Model.Korisnici> Login(KorisniciLoginRequest request);

        public Task<Model.Korisnici> Register(KorisniciInsertRequest request);

        public Task<List<Model.Korisnici>> TopUsers();
    }
}
