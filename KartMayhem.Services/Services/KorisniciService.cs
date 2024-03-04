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
    public class KorisniciService : BaseCRUDService<Model.Korisnici, Database.Korisnici, BaseSearchObject, KorisniciInsertRequest, object>, IKorisniciService
    {
        public KorisniciService(KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);


            return Convert.ToBase64String(byteArray);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }


        public async Task<Model.Korisnici> Login(KorisniciLoginRequest user)
        {
            var entity = _context.Korisnicis.Include("KorisniciUloges.Uloga").FirstOrDefault(x => x.Email == user.Email) 
                ?? throw new UserException("Neispravni podaci", "Netacan email ili lozinka!");
            
            var hash = GenerateHash(entity.LozinkaSalt, user.Lozinka);

            if (hash != entity.LozinkaHash)
            {
                throw new UserException("Neispravni podaci", "Netacan email ili lozinka!");
            }

            return _mapper.Map<Model.Korisnici>(entity);
        }

        public async Task<Model.Korisnici> Register(KorisniciInsertRequest korisniciInsertRequest)
        {
            var korisnici = _context.Set<Database.Korisnici>().AsQueryable();

            if (korisnici.Any(x => x.Email == korisniciInsertRequest.Email))
            {
                throw new UserException("Email u upotrebi", "Email je u upotrebi!");
            }

            var korisniciDb = _mapper.Map<Database.Korisnici>(korisniciInsertRequest);

            korisniciDb.LozinkaSalt = GenerateSalt();
            korisniciDb.LozinkaHash = GenerateHash(korisniciDb.LozinkaSalt, korisniciInsertRequest.Lozinka);

            _context.Add(korisniciDb);
            _context.SaveChanges();

            foreach (var role in korisniciInsertRequest.Uloge)
            {
                Database.KorisniciUloge korisnikUloge = new Database.KorisniciUloge
                {
                    KorisnikId = korisniciDb.Id,
                    UlogaId = role
                };
                _context.KorisniciUloges.Add(korisnikUloge);
            }

            _context.SaveChanges();

            return _mapper.Map<Model.Korisnici>(korisniciDb);
        }
    }
}
