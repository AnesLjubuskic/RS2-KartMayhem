using KartMayhem.Model;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace KartMayhem.Controllers
{
    [Route("[controller]")]
    public class NagradeController : BaseController<Model.Nagrade, Model.SearchObject.BaseSearchObject>
    {
        public NagradeController(ILogger<BaseController<Nagrade, BaseSearchObject>> logger, INagradeService service) : base(logger, service)
        {
        }
    }
}
