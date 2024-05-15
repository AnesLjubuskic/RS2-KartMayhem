using AutoMapper;
using KartMayhem.Model.Exception;
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
    public class StazeService : BaseCRUDService<Model.Staze, Database.Staze, StazeSearchObject, StazeUpsertRequest, StazeUpsertRequest>, IStazeService
    {
        public StazeService(KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override Task BeforeInsert(Staze entity, StazeUpsertRequest insert)
        {
            entity.IsActive = true;
            return base.BeforeInsert(entity, insert);
        }

        public override IQueryable<Staze> AddFilter(IQueryable<Staze> query, StazeSearchObject? search = null)
        {
            var filter = base.AddFilter(query, search);

            filter = filter.Where(x => x.IsActive);

            if (search != null && !string.IsNullOrWhiteSpace(search.NazivStaze))
                filter = filter.Where(x => x.NazivStaze.ToLower().Contains(search.NazivStaze.ToLower()));

            if (search != null && search.TezineId != null && search.TezineId.Count() > 0)
            {
                filter = filter.Where(x => search.TezineId.Contains(x.TezinaId));
            }

            return filter;
        }

        public async Task<bool> DeactivateTrack(int trackId)
        {
            var staza = _context.Set<Database.Staze>().Find(trackId);

            if (staza == null)
            {
                throw new UserException("Staza ne postoji", "Staza ne postoji!");
            }

            staza.IsActive = false;

            await _context.SaveChangesAsync();

            return true;
        }

        public override IQueryable<Staze> AddInclude(IQueryable<Staze> query, StazeSearchObject? search = null)
        {
            var includeQuery = base.AddInclude(query, search);
            includeQuery = includeQuery.Include(x => x.Tezina);

            return includeQuery;
        }
    }
}
