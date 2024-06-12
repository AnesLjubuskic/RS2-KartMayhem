namespace KartMayhem.Model
{
    public static class ReservationSlots
    {
        public static List<string> getReservationSlots()
        {
            List<string> timeSlots = new List<string>()
            {
                "08:00",
                "09:00",
                "10:00",
                "11:00",
                "12:00",
                "13:00",
                "14:00",
                "15:00",
                "16:00",
            };
            return timeSlots;
        }
    }
}
