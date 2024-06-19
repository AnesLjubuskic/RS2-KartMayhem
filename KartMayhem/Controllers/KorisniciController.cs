using KartMayhem.Model;
using KartMayhem.Model.SearchObject;
using KartMayhem.Model.UserRequestObjects;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace KartMayhem.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [Authorize]
    public class KorisniciController : BaseCRUDController<Model.Korisnici, Model.SearchObject.KorisniciSearchObject, object, object>
    {

        private readonly IKorisniciService _korisniciService;
        public KorisniciController(ILogger<BaseCRUDController<Korisnici, KorisniciSearchObject, object, object>> logger,IKorisniciService service) 
            : base(logger, service)
        {            
            _korisniciService = service;
        }

        [Authorize(Roles = "Admin")]
        [HttpGet("topUsers")]
        public async Task<List<Model.Korisnici>> TopUsers()
        {
            return await _korisniciService.TopUsers();
        }

        [Authorize(Roles = "Admin")]
        [HttpPut("rewardUser/{id}")]
        public async Task<bool> RewardUser(int id)
        {
            return await _korisniciService.RewardUser(id);
        }

        [Authorize(Roles = "Admin")]
        [HttpPut("cancelUserReward/{id}")]
        public async Task<bool> CancelUserReward(int id)
        {
            return await _korisniciService.CancelRewardUser(id);
        }

        [Authorize(Roles = "Admin")]
        [HttpPut("deactivateUser/{id}")]
        public async Task<bool> DeactivateUser(int id)
        {
            return await _korisniciService.DeactivateUser(id);
        }

        [HttpPut("editUserByAdmin/{id}")]
        public async Task<bool> EditUserByAdmin(int id, [FromBody] KorisniciUpdateByAdminRequest request)
        {
            return await _korisniciService.EditUserByAdmin(id, request);
        }
    }
}
