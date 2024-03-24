using KartMayhem.Model;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace KartMayhem.Controllers
{
    [ApiController]
    [Authorize]
    public class TezineController : BaseController<Model.Tezine, Model.SearchObject.BaseSearchObject>
    {
        public TezineController(ILogger<BaseController<Tezine, BaseSearchObject>> logger, ITezinaService service) : base(logger, service)
        {
        }
    }
}
