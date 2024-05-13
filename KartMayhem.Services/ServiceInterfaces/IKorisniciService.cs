using KartMayhem.Model;
using KartMayhem.Model.SearchObject;
using KartMayhem.Model.UserRequestObjects;

namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IKorisniciService : IBaseService<Model.Korisnici, Model.SearchObject.KorisniciSearchObject>
    {
        public Task<List<Model.Korisnici>> TopUsers();
        public Task<bool> RewardUser(int userId);
        public Task<bool> CancelRewardUser(int userId);

    }
}
