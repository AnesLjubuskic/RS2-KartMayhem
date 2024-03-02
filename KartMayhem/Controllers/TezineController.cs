using KartMayhem.Model;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.AspNetCore.Mvc;

namespace KartMayhem.Controllers
{
    [ApiController]
    public class TezineController : BaseController<Model.Tezine, Model.SearchObject.BaseSearchObject>
    {
        public TezineController(ILogger<BaseController<Tezine, BaseSearchObject>> logger, ITezinaService service) : base(logger, service)
        {
        }
    }
}
