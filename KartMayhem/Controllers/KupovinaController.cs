using KartMayhem.Model;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace KartMayhem.Controllers
{
    [Route("[controller]")]
    public class KupovinaController : BaseCRUDController<Model.Kupovina, BaseSearchObject, KupovinaInsertRequest, KupovinaInsertRequest>
    {
        public IKupovinaService _service { get; set; }
        public KupovinaController(ILogger<BaseController<Kupovina, BaseSearchObject>> logger, IKupovinaService service) : base(logger, service)
        {
            _service = service;
        }

        [Authorize]
        public async override Task<Kupovina> Insert([FromBody] KupovinaInsertRequest insert)
        {
            return _service.Plati(insert);
        }
    }
}
