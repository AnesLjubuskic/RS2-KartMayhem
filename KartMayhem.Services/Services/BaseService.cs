using AutoMapper;
using KartMayhem.Model;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.Database;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.EntityFrameworkCore;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace KartMayhem.Services.Services
{
    public class BaseService<T, TDb, TSearch> : IBaseService<T, TSearch> where TDb : class where T : class where TSearch : BaseSearchObject
    {
        protected KartMayhemContext _context;
        protected IMapper _mapper { get; set; }
        public BaseService(KartMayhemContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public virtual async Task<PagedResult<T>> Get(TSearch? search = null)
        {
            var query = _context.Set<TDb>().AsQueryable();

            PagedResult<T> result = new PagedResult<T>();

            result.TotalCount = await query.CountAsync();

            if (typeof(TDb) == typeof(Database.Staze))
            {
                var queryReservation = query as IQueryable<Database.Staze>;

                if (queryReservation != null)
                {
                    result.TotalCount = await queryReservation.Where(x => x.IsActive).CountAsync();
                }
            }

            if (typeof(TDb) == typeof(Database.Korisnici))
            {
                var queryReservation = query as IQueryable<Database.Korisnici>;

                if (queryReservation != null)
                {
                    result.TotalCount = await queryReservation.Where(x => x.IsActive).CountAsync();
                }
            }

            if (typeof(TDb) == typeof(Database.Rezervacije))
            {
                var queryReservation = query as IQueryable<Database.Rezervacije>;

                if (queryReservation != null)
                {
                    result.TotalCount = await queryReservation.Where(x => !x.isCancelled).CountAsync();

                    result.TotalReservationProfit = await queryReservation.Where(x => !x.isCancelled).SumAsync(x => x.CijenaRezervacije);
                }
            }
            else
            {
                result.TotalReservationProfit = 0;
            }

            query = AddFilter(query, search);

            query = AddInclude(query, search);

            result.Count = await query.CountAsync();

            if (typeof(TDb) == typeof(Database.Rezervacije))
            {
                var queryReservation = query as IQueryable<Database.Rezervacije>;

                if (queryReservation != null) 
                { 
                    result.ReservationProfit = await queryReservation.Where(x => !x.isCancelled).SumAsync(x => x.CijenaRezervacije);
                }

            }
            else
            {
                result.ReservationProfit = 0;
            }

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip(search.Page.Value * search.PageSize.Value).Take(search.PageSize.Value);
            }

            var list = await query.ToListAsync();


            var tmp = _mapper.Map<List<T>>(list);

            tmp = AddPostMapFilter(tmp, search);

            result.Result = tmp;
            return result;
        }

        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

        public virtual List<T> AddPostMapFilter(List<T> query, TSearch? search = null)
        {
            return query;
        }

        public virtual TDb AddFilterById(TDb entity, int id)
        {
            return entity;
        }

        public virtual async Task<T> GetById(int id)
        {
            var entity = await _context.Set<TDb>().FindAsync(id);

            entity = AddFilterById(entity, id);

            return _mapper.Map<T>(entity);
        }
    }
}
