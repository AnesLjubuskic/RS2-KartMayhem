using AutoMapper;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.Database;
using KartMayhem.Services.ServiceInterfaces;

namespace KartMayhem.Services.Services
{
    public class TezineService : BaseService<Model.Tezine, Database.Tezine, BaseSearchObject>, ITezinaService
    {
        public TezineService(KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
