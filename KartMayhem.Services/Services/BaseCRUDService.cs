﻿using AutoMapper;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.Database;

namespace KartMayhem.Services.Services
{
    public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb, TSearch> where TDb : class where T : class where TSearch : BaseSearchObject
    {
        public string problem = "Problem u poslanim podacima";

        public BaseCRUDService(IB190060_KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public virtual async Task ValidationInsert(TInsert insert)
        {

        }

        public virtual async Task ValidationUpdate(TUpdate update)
        {

        }

        public virtual async Task BeforeInsert(TDb entity, TInsert insert)
        {

        }

        public virtual async Task AfterInsert(TDb entity, TInsert insert)
        {

        }

        public virtual async Task AfterUpdate(TDb entity)
        {

        }

        public virtual async Task<T> Insert(TInsert insert)
        {
            await ValidationInsert(insert);
            
            var set = _context.Set<TDb>();

            TDb entity = _mapper.Map<TDb>(insert);

            set.Add(entity);
            await BeforeInsert(entity, insert);

            await _context.SaveChangesAsync();
            await AfterInsert(entity, insert);
            return _mapper.Map<T>(entity);
        }


        public virtual async Task<T> Update(int id, TUpdate update)
        {
            await ValidationUpdate(update);

            var set = _context.Set<TDb>();

            var entity = await set.FindAsync(id);

            _mapper.Map(update, entity);

            await AfterUpdate(entity);

            await _context.SaveChangesAsync();
            return _mapper.Map<T>(entity);
        }

    }
}
