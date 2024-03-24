using AutoMapper;

namespace KartMayhem.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.Tezine, Model.Tezine>();
            CreateMap<Database.Korisnici, Model.Korisnici>();
            CreateMap<Database.KorisniciUloge, Model.KorisniciUloge>();
            CreateMap<Database.Uloge, Model.Uloge>();
            CreateMap<Database.Nagrade, Model.Nagrade>();
            CreateMap<Model.UserRequestObjects.KorisniciInsertRequest, Database.Korisnici>();
        }
    }
}
