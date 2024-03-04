using KartMayhem.Model;
using KartMayhem.Model.SearchObject;
using KartMayhem.Model.UserRequestObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IKorisniciService : IBaseCRUDService<Korisnici, BaseSearchObject, KorisniciInsertRequest, object>
    {
        public Task<Model.Korisnici> Login(KorisniciLoginRequest request);

        public Task<Model.Korisnici> Register(KorisniciInsertRequest request);
    }
}
