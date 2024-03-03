using AutoMapper;

namespace KartMayhem.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.Tezine, Model.Tezine>();
            CreateMap<Database.Korisnici, Model.Korisnici>();
        }
    }
}
