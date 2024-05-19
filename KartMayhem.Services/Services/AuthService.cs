using AutoMapper;
using KartMayhem.Model.Exception;
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
    public class AuthService : IAuthService
    {
        protected KartMayhemContext _context;
        protected IMapper _mapper { get; set; }

        public AuthService(KartMayhemContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Korisnici> Login(KorisniciLoginRequest request)
        {
            var entity = await _context.Korisnicis.Include("KorisniciUloges.Uloga")
                .FirstOrDefaultAsync(x => x.Email == request.Email);

            if (entity == null)
            {
                throw new UserException("Netačan email ili lozinka!");
            }

            var hash = GenerateHash(entity.LozinkaSalt, request.Lozinka);

            if (hash != entity.LozinkaHash)
            {
                throw new UserException("Netačan email ili lozinka!");
            }
            return _mapper.Map<Model.Korisnici>(entity);
        }

        public async Task<Model.Korisnici> LoginAdmin(KorisniciLoginRequest request)
        {
            bool admin = false;
            var entity = await _context.Korisnicis.Include("KorisniciUloges.Uloga").FirstOrDefaultAsync(x => x.Email == request.Email);

            if (entity == null)
            {
                throw new UserException("Netačan email ili lozinka!");
            }

            var uloge = _context.KorisniciUloges.Include(x => x.Uloga).Where(x => x.KorisnikId == entity.Id).ToList();

            foreach (var uloga in uloge)
            {
                if (uloga.Uloga.Naziv == "Admin")
                {
                    admin = true;
                }
            }

            var hash = GenerateHash(entity.LozinkaSalt, request.Lozinka);

            if (hash == entity.LozinkaHash)
            {
                if (admin)
                    return _mapper.Map<Model.Korisnici>(entity);
            }

            throw new UserException("Netačan email ili lozinka!");
        }

        public async Task<Model.Korisnici> Register(KorisniciInsertRequest request)
        {
            var korisnici = _context.Set<Database.Korisnici>().AsQueryable();

            if (korisnici.Any(x => x.Email == request.Email))
            {
                throw new UserException("Email je u upotrebi!");
            }

            var korisniciDb = _mapper.Map<Database.Korisnici>(request);

            korisniciDb.LozinkaSalt = GenerateSalt();
            korisniciDb.LozinkaHash = GenerateHash(korisniciDb.LozinkaSalt, request.Lozinka);
            korisniciDb.IsActive = true;

            _context.Add(korisniciDb);
            _context.SaveChanges();

            foreach (var role in request.Uloge)
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
    }
}
