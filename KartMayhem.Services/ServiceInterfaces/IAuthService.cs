using KartMayhem.Model.UserRequestObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IAuthService
    {
        public Task<Model.Korisnici> Register(KorisniciInsertRequest request);
        public Task<Model.Korisnici> Login(KorisniciLoginRequest request);
        public Task<Model.Korisnici> LoginAdmin(KorisniciLoginRequest request);
    }
}
