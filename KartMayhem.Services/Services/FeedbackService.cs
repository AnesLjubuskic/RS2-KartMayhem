using AutoMapper;
using KartMayhem.Model.Exception;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.Database;
using KartMayhem.Services.ServiceInterfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.Services
{
    public class FeedbackService : BaseCRUDService<Model.Feedback, Database.Feedback, BaseSearchObject, FeedbackInsertRequest, object>, IFeedbackService
    {
        public FeedbackService(KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override Task BeforeInsert(Feedback entity, FeedbackInsertRequest insert)
        {
            if (insert == null)
            {
                throw new FeedbackException("Feedback ne posjeduje vrijednost!");
            }

            if (string.IsNullOrWhiteSpace(insert.Komentar))
            {
                throw new FeedbackException("Feedback ne smije biti prazan!");
            }

            if (insert.KorisnikId == null)
            {
                throw new FeedbackException("Feedback mora sadržati korisnika!");
            }

            var user = _context.Korisnicis.Find(insert.KorisnikId);

            if (user == null) 
            {
                throw new FeedbackException("Korisnik ne postoji!");
            }

            if (insert.Komentar.Length < 1 || insert.Komentar.Length>150)
            {
                throw new FeedbackException("Feedback mora imati više od 0, a manje od 150 karaktera!");
            }

            return base.BeforeInsert(entity, insert);
        }
    }
}
