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
    public class GradoviService : BaseService<Model.Gradovi, Database.Gradovi, BaseSearchObject>, IGradoviService
    {
        public GradoviService(IB190060_KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
