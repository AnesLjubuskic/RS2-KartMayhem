using KartMayhem.Model;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace KartMayhem.Controllers
{
    [Route("[controller]")]
    public class FeedbackController : BaseCRUDController<Feedback, BaseSearchObject, FeedbackInsertRequest, object>
    {
        public FeedbackController(ILogger<BaseController<Feedback, BaseSearchObject>> logger, IFeedbackService service) : base(logger, service)
        {
        }
    }
}
