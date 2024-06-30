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
    public class RezencijeService : BaseCRUDService<Model.Rezencije, Database.Rezencije, BaseSearchObject, RezencijaInsertRequest, object>, IRezencijeService
    {
        public RezencijeService(IB190060_KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override Task ValidationInsert(RezencijaInsertRequest insert)
        {
            if (insert == null)
            {
                throw new RezencijeException("Rezencija ne posjeduje vrijednost!");
            }

            if (insert.StazaId == null)
            {
                throw new RezencijeException("Rezenciji je potrebna staza!");
            }

            if (insert.Ocjena == null)
            {
                throw new RezencijeException("Rezenciji je potrebna ocjena!");
            }

            if (insert.Ocjena < 1 || insert.Ocjena > 4)
            {
                throw new RezencijeException("Rezenciji mora biti od 1 do 4!");
            }

            var staza = _context.Stazes.Find(insert.StazaId);

            if (staza == null)
            {
                throw new RezencijeException("Staza ne postoji!");
            }

            return base.ValidationInsert(insert);
        }
    }
}
