using AutoMapper;
using KartMayhem.Model;
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
    public class KupovinaService : BaseCRUDService<Model.Kupovina, Database.Kupovina, BaseSearchObject, KupovinaInsertRequest, KupovinaInsertRequest>, IKupovinaService
    {
        private IRezervacijeService _rezervacijeService { get; set; }
        public StripeService _stripeService { get; set; }

        public KupovinaService(KartMayhemContext context, IMapper mapper, StripeService stripeService, IRezervacijeService rezervacijeService) : base(context, mapper)
        {
            _stripeService = stripeService;
            _rezervacijeService = rezervacijeService;
        }

        public Model.Kupovina Plati(KupovinaInsertRequest request)
        {
            var staza = _context.Stazes.First(x => x.Id == request.StazaId);
            if (staza == null)
                throw new Exception("Staza nije pronađena");

            Database.Kupovina kupovina = new Database.Kupovina();
            kupovina.KorisnikId = (int)request.KorisnikId;
            kupovina.DatumKupovine = DateTime.Now;
            kupovina.Cijena = request.Cijena;
            kupovina.StazeId = request.StazaId;
            kupovina.Placena = true;
            _context.Add(kupovina);
            _context.SaveChanges();

            var paymentId = _stripeService.PlatiRezervaciju(kupovina.Cijena, $"Kupovina za ({kupovina.DatumKupovine})");
            kupovina.PaymentIntentId = paymentId;
            _context.SaveChanges();
            return _mapper.Map<Model.Kupovina>(kupovina);
        }

        public IEnumerable<Model.Kupovina> GetByKorisnikId(int id)
        {
            throw new NotImplementedException();
        }
    }
}
