using KartMayhem.Model;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.ServiceInterfaces;
using KartMayhem.Services.Services;
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

        [HttpPut("deactivateTrack/{id}")]
        public async Task<bool> DeactivateUser(int id)
        {
            return await _stazeService.DeactivateTrack(id);
        }
    }
}
