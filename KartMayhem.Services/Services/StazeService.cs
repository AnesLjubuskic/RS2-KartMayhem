using AutoMapper;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.Database;
using KartMayhem.Services.ServiceInterfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.Services
{
    public class StazeService : BaseCRUDService<Model.Staze, Database.Staze, BaseSearchObject, object, object>, IStazeService
    {
        public StazeService(KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
