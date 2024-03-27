using AutoMapper;

namespace KartMayhem.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            // Basic requests
            CreateMap<Database.Tezine, Model.Tezine>();
            CreateMap<Database.Korisnici, Model.Korisnici>();
            CreateMap<Database.KorisniciUloge, Model.KorisniciUloge>();
            CreateMap<Database.Uloge, Model.Uloge>();
            CreateMap<Database.Nagrade, Model.Nagrade>();
            CreateMap<Database.Rezencije, Model.Rezencije>();
            CreateMap<Database.Staze, Model.Staze>()
                .ForMember(dest => dest.BrojRezervacija, opt => opt.MapFrom(src => src.Rezervacijes.Count));

            // Insert requests
            CreateMap<Model.UserRequestObjects.KorisniciInsertRequest, Database.Korisnici>();
            CreateMap<Model.RequestObjects.StazeUpsertRequest, Database.Staze>();

            // Update requests
        }
    }
}
