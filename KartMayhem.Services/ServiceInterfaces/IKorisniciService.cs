using KartMayhem.Model;
using KartMayhem.Model.SearchObject;
using KartMayhem.Model.UserRequestObjects;

namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IKorisniciService : IBaseCRUDService<Model.Korisnici, Model.SearchObject.KorisniciSearchObject, object, object>
    {
        public Task<List<Model.Korisnici>> TopUsers();
        public Task<bool> RewardUser(int userId);
        public Task<bool> CancelRewardUser(int userId);
        public Task<bool> DeactivateUser(int userId);
        public Task<bool> EditUserByAdmin(int userId, KorisniciUpdateByAdminRequest request);
    }
}
