﻿using AutoMapper;

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
            CreateMap<Database.Rezencije, Model.Rezencije>();
            CreateMap<Database.Rezervacije, Model.Rezervacije>();
            CreateMap<Database.Feedback, Model.Feedback>();
            CreateMap<Database.Gradovi, Model.Gradovi>();
            CreateMap<Database.Izvjestaji, Model.Izvjestaji>();
            CreateMap<Database.Staze, Model.Staze>()
                .ForMember(dest => dest.BrojRezervacija, opt => opt.MapFrom(src => src.Rezervacijes.Count));
            CreateMap<Database.Staze, Model.UniqueGetRequests.StazeForRezervacije>();

            // Upsert requests
            CreateMap<Model.RequestObjects.StazeUpsertRequest, Database.Staze>();
            CreateMap<Model.RequestObjects.RezervacijeUpsertRequest, Database.Rezervacije>();

            // Insert requests
            CreateMap<Model.UserRequestObjects.KorisniciInsertRequest, Database.Korisnici>();
            CreateMap<Model.RequestObjects.RezencijaInsertRequest, Database.Rezencije>();
            CreateMap<Model.RequestObjects.FeedbackInsertRequest, Database.Feedback>();
            CreateMap<Model.RequestObjects.IzvjestajiInsertRequest, Database.Izvjestaji>();

            // Update requests
        }
    }
}
