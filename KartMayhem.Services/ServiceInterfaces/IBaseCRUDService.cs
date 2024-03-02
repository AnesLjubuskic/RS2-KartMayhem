namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IBaseCRUDService<T, TSearch, TInsert, TUpdate> : IBaseService<T, TSearch> where TSearch : class
    {
        Task<T> Insert(TInsert insert);
        Task<T> Update(int id, TUpdate update);
    }
}
