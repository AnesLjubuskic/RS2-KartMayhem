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
    public class RezencijeService : BaseCRUDService<Model.Rezencije, Database.Rezencije, BaseSearchObject, object, object>, IRezencijeService
    {
        public RezencijeService(KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
