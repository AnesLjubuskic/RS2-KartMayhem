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
            CreateMap<Database.Kupovina, Model.Kupovina>();
            CreateMap<Database.Uloge, Model.Uloge>();
            CreateMap<Database.Nagrade, Model.Nagrade>();
            CreateMap<Database.Rezencije, Model.Rezencije>();
            CreateMap<Database.Opreme, Model.Opreme>();
            CreateMap<Database.RezervacijeOpreme, Model.RezervacijeOpreme>();
            CreateMap<Database.Rezervacije, Model.Rezervacije>();
            CreateMap<Database.Staze, Model.Staze>()
                .ForMember(dest => dest.BrojRezervacija, opt => opt.MapFrom(src => src.Rezervacijes.Count));
            CreateMap<Database.Staze, Model.UniqueGetRequests.StazeForRezervacije>();

            // Upsert requests
            CreateMap<Model.RequestObjects.StazeUpsertRequest, Database.Staze>();
            CreateMap<Model.RequestObjects.RezervacijeUpsertRequest, Database.Rezervacije>();

            // Insert requests
            CreateMap<Model.UserRequestObjects.KorisniciInsertRequest, Database.Korisnici>();

            // Update requests
        }
    }
}
