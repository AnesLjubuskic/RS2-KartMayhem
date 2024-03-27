using KartMayhem.Model;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.AspNetCore.Mvc;

namespace KartMayhem.Controllers
{
    [Route("[controller]")]
    public class StazeController : BaseCRUDController<Model.Staze, BaseSearchObject, StazeUpsertRequest, StazeUpsertRequest>
    {
        protected IStazeService _stazeService { get; set; }

        public StazeController(ILogger<BaseController<Staze, BaseSearchObject>> logger, IStazeService service) 
            : base(logger, service)
        {
            _stazeService = service;
        }
    }
}
