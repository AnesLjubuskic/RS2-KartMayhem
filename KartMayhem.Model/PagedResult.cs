namespace KartMayhem.Model
{
    public class PagedResult<T>
    {
        public List<T> Result { get; set; }
        public int? Count { get; set; }
        public int? TotalCount { get; set; }
        public int? ReservationProfit { get; set; }
        public int? TotalReservationProfit { get; set; }

    }
}
