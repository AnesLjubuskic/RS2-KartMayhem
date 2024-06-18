using KartMayhem.Model;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.ServiceInterfaces;
using KartMayhem.Services.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace KartMayhem.Controllers
{
    [Route("[controller]")]
    public class StazeController : BaseCRUDController<Model.Staze, StazeSearchObject, StazeUpsertRequest, StazeUpsertRequest>
    {
        protected IStazeService _stazeService { get; set; }

        public StazeController(ILogger<BaseController<Staze, StazeSearchObject>> logger, IStazeService service) 
            : base(logger, service)
        {
            _stazeService = service;
        }

        [Authorize(Roles = "Admin")]
        [HttpPut("deactivateTrack/{id}")]
        public async Task<bool> DeactivateTrack(int id)
        {
            return await _stazeService.DeactivateTrack(id);
        }

        [Authorize(Roles = "Admin")]
        public override Task<Staze> Insert([FromBody] StazeUpsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Admin")]
        public override Task<Staze> Update(int id, [FromBody] StazeUpsertRequest update)
        {
            return base.Update(id, update);
        }

        [HttpGet("favouriteTracks")]
        public async Task<PagedResult<Model.Staze>> FavouriteTracks(int userId)
        {
            return await _stazeService.FavouriteTracks(userId);
        }

        [HttpPut("markFavouriteTrack")]
        public async Task<bool> MarkFavouriteTrack(int id, int userId)
        {
            return await _stazeService.MarkFavouriteTrack(id, userId);
        }
    }
}
