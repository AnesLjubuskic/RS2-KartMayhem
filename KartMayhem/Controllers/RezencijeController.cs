using KartMayhem.Model;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.AspNetCore.Mvc;

namespace KartMayhem.Controllers
{
    [Route("[controller]")]
    public class RezencijeController : BaseCRUDController<Rezencije, BaseSearchObject, object, object>
    {
        protected IRezencijeService _rezencijeService { get; set; }
        public RezencijeController(ILogger<BaseController<Rezencije, BaseSearchObject>> logger, IRezencijeService service) : base(logger, service)
        {
            _rezencijeService = service;
        }
    }
}
