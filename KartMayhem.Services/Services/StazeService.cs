using AutoMapper;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.Database;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.Services
{
    public class StazeService : BaseCRUDService<Model.Staze, Database.Staze, BaseSearchObject, StazeUpsertRequest, StazeUpsertRequest>, IStazeService
    {
        public StazeService(KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Staze> AddInclude(IQueryable<Staze> query, BaseSearchObject? search = null)
        {
            var includeQuery = base.AddInclude(query, search);
            includeQuery = includeQuery.Include(x => x.Tezina);

            return includeQuery;
        }
    }
}
