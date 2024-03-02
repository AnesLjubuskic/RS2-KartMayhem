using KartMayhem.Model;

namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IBaseService<T, TSearch> where TSearch : class
    {
        Task<PagedResult<T>> Get(TSearch search = null);
        Task<T> GetById(int id);
    }
}
