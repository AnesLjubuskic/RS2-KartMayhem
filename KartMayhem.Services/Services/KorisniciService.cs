using AutoMapper;
using KartMayhem.Model.Exception;
using KartMayhem.Model.SearchObject;
using KartMayhem.Model.UserRequestObjects;
using KartMayhem.Services.Database;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.Services
{
    public class KorisniciService : BaseService<Model.Korisnici, Database.Korisnici, Model.SearchObject.BaseSearchObject>, IKorisniciService
    {
        public KorisniciService(KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public async Task<List<Model.Korisnici>> TopUsers()
        {
            var korisnici = _context.Set<Database.Korisnici>().Include(x => x.Nagrada).OrderByDescending(x => x.BrojRezervacija).Take(5);

            return _mapper.Map<List<Model.Korisnici>>(korisnici);
        }
    }
}
