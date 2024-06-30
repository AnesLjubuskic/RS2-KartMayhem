using KartMayhem.Model;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace KartMayhem.Controllers
{
    [Route("[controller]")]
    public class GradoviController : BaseController<Model.Gradovi, Model.SearchObject.BaseSearchObject>
    {
        public GradoviController(ILogger<BaseController<Gradovi, BaseSearchObject>> logger, IGradoviService service) : base(logger, service)
        {
        }
    }
}
