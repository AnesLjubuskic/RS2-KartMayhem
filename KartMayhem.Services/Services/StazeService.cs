using AutoMapper;
using KartMayhem.Model;
using KartMayhem.Model.Exception;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.Database;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace KartMayhem.Services.Services
{
    public class StazeService : BaseCRUDService<Model.Staze, Database.Staze, StazeSearchObject, StazeUpsertRequest, StazeUpsertRequest>, IStazeService
    {
        public StazeService(IB190060_KartMayhemContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override Task ValidationInsert(StazeUpsertRequest insert)
        {
            if (string.IsNullOrEmpty(insert.NazivStaze) || string.IsNullOrWhiteSpace(insert.NazivStaze) || insert.NazivStaze.Length < 1 || insert.NazivStaze.Length > 20)
            {
                throw new StazeException("Dužina naziva treba biti od 1 do 20!");
            }

            if (string.IsNullOrEmpty(insert.OpisStaze) || string.IsNullOrWhiteSpace(insert.OpisStaze) || insert.OpisStaze.Length < 1 || insert.OpisStaze.Length > 200)
            {
                throw new StazeException("Dužina opisa treba biti od 1 do 200!");
            }

            if (insert.DuzinaStaze < 0.5 || insert.DuzinaStaze > 10.0)
            {
                throw new StazeException("Vrijednost dužine staze treba biti između 0.5 i 10.0!");
            }

            if (insert.MaxBrojOsoba < 1 || insert.MaxBrojOsoba > 8)
            {
                throw new StazeException("Vrijednost maksimalnog broja ljudi mora biti između 1 i 8!");
            }

            if (insert.BrojKrugova < 1 || insert.BrojKrugova > 5)
            {
                throw new StazeException("Vrijednost broja krugova mora biti između 1 i 8!");
            }

            if (insert.CijenaPoOsobi < 1 || insert.CijenaPoOsobi > 999)
            {
                throw new StazeException("Vrijednost cijene po osobi mora biti između 1 i 999!");
            }

            if (insert.TezinaId != 1 && insert.TezinaId != 2 && insert.TezinaId != 3)
            {
                throw new StazeException("Vrijednost težine nije validna!");
            }

            return base.ValidationInsert(insert);
        }

        public override Task ValidationUpdate(StazeUpsertRequest update)
        {
            if (string.IsNullOrEmpty(update.NazivStaze) || string.IsNullOrWhiteSpace(update.NazivStaze) || update.NazivStaze.Length < 1 || update.NazivStaze.Length > 20)
            {
                throw new StazeException("Dužina naziva treba biti od 1 do 20!");
            }

            if (string.IsNullOrEmpty(update.OpisStaze) || string.IsNullOrWhiteSpace(update.OpisStaze) || update.OpisStaze.Length < 1 || update.OpisStaze.Length > 200)
            {
                throw new StazeException("Dužina opisa treba biti od 1 do 200!");
            }

            if (update.DuzinaStaze < 0.5 || update.DuzinaStaze > 10.0)
            {
                throw new StazeException("Vrijednost dužine staze treba biti između 0.5 i 10.0!");
            }

            if (update.MaxBrojOsoba < 1 || update.MaxBrojOsoba > 8)
            {
                throw new StazeException("Vrijednost maksimalnog broja ljudi mora biti između 1 i 8!");
            }

            if (update.BrojKrugova < 1 || update.BrojKrugova > 5)
            {
                throw new StazeException("Vrijednost broja krugova mora biti između 1 i 8!");
            }

            if (update.CijenaPoOsobi < 1 || update.CijenaPoOsobi > 999)
            {
                throw new StazeException("Vrijednost cijene po osobi mora biti između 1 i 999!");
            }

            if (update.TezinaId != 1 && update.TezinaId != 2 && update.TezinaId != 3)
            {
                throw new StazeException("Vrijednost težine nije validna!");
            }

            return base.ValidationUpdate(update);
        }

        public override Task BeforeInsert(Database.Staze entity, StazeUpsertRequest insert)
        {
            entity.IsActive = true;

            var pictureValue = _context.Tezines.Find(insert.TezinaId);
            
            if (pictureValue == null)
            {
                throw new StazeException("Tezina id nije validna!");
            }
            
            entity.Slika = pictureValue.Slika;
            
            return base.BeforeInsert(entity, insert);
        }

        public override Task AfterUpdate(Database.Staze entity)
        {
            var pictureValue = _context.Tezines.Find(entity.TezinaId);

            if (pictureValue == null)
            {
                throw new StazeException("Tezina id nije validna!");
            }

            entity.Slika = pictureValue.Slika;

            return base.AfterUpdate(entity);
        }

        public override IQueryable<Database.Staze> AddFilter(IQueryable<Database.Staze> query, StazeSearchObject? search = null)
        {
            var filter = base.AddFilter(query, search);

            filter = filter.Where(x => x.IsActive);

            if (search != null && !string.IsNullOrWhiteSpace(search.NazivStaze))
                filter = filter.Where(x => x.NazivStaze.ToLower().Contains(search.NazivStaze.ToLower()));

            if (search != null && search.TezineId != null && search.TezineId.Count() > 0)
            {
                filter = filter.Where(x => search.TezineId.Contains(x.TezinaId));
            }

            return filter;
        }

        public override List<Model.Staze> AddPostMapFilter(List<Model.Staze> query, StazeSearchObject? search = null)
        {
            var filter = base.AddPostMapFilter(query, search);

            if (search != null && search.UserId != null)
            {
                var korisniciStazes = _context.KorisniciStazes.Where(x => x.KorisniciId == search.UserId);

                foreach(var korisniciStaze in korisniciStazes)
                {
                    foreach(var querySingle in filter)
                    {
                        if (querySingle.Id == korisniciStaze.StazeId)
                        {
                            querySingle.Favourite = true;
                        }
                    }
                }
            }
            return filter;
        }

        public async Task<bool> DeactivateTrack(int trackId)
        {
            var staza = _context.Set<Database.Staze>().Find(trackId);

            if (staza == null)
            {
                throw new StazeException("Staza ne postoji!");
            }

            staza.IsActive = false;

            await _context.SaveChangesAsync();

            return true;
        }

        public override IQueryable<Database.Staze> AddInclude(IQueryable<Database.Staze> query, StazeSearchObject? search = null)
        {
            var includeQuery = base.AddInclude(query, search);
            includeQuery = includeQuery.Include(x => x.Tezina).Include(x => x.Gradovi);

            return includeQuery;
        }

        public async override Task<Model.Staze> GetById(int id)
        {
            var staza = _context.Set<Database.Staze>().Include(x => x.Tezina).Include(x => x.Gradovi).Include(x => x.Rezencijes).FirstOrDefault(x => x.Id == id);

            if (staza == null)
            {
                throw new StazeException("Staza ne postoji!");
            }

            var mappedStaza = _mapper.Map<Model.Staze>(staza);

            if (staza.Rezencijes == null || !staza.Rezencijes.Any())
            {
                mappedStaza.Ocjena = 0;
            }
            else
            {
                var ocjena = 0.0;
                foreach (var rezencija in staza.Rezencijes)
                {
                    ocjena = ocjena + rezencija.Ocjena;
                }
                ocjena /= staza.Rezencijes.Count();
                mappedStaza.Ocjena = (int)Math.Ceiling(ocjena);
            }

            return mappedStaza;
        }

        public async Task<Model.PagedResult<Model.Staze>> FavouriteTracks(int userId)
        {
            var korisniciStaze = _context.KorisniciStazes.Where(x => x.KorisniciId == userId);
            PagedResult<Model.Staze> result = new PagedResult<Model.Staze>();
            List<Database.Staze> stazeFavoriti = new List<Database.Staze>();
            result.TotalCount = await korisniciStaze.CountAsync();

            var staze = _context.Stazes.Include(x => x.Tezina).Where(x => x.IsActive);

            foreach(var korisniciStaza in korisniciStaze)
            {
                foreach(var staza in staze)
                {
                    if (staza.Id == korisniciStaza.StazeId)
                    {
                        stazeFavoriti.Add(staza);
                        break;
                    }
                }
            }

            var mappedStaze = _mapper.Map<List<Model.Staze>>(stazeFavoriti);

            foreach(var staza in mappedStaze)
            {
                staza.Favourite = true;
            }

            result.Result = mappedStaze;
            result.Count = mappedStaze.Count();

            return result;
        }

        public async Task<bool> MarkFavouriteTrack(int id, int userId)
        {
            var staza = _context.Stazes.Where(x => x.Id == id);
            var stazaKorisnikDB = _context.KorisniciStazes;
            var stazeKorisnik = _context.KorisniciStazes.Where(x => x.KorisniciId == userId && x.StazeId == id).FirstOrDefault();
            
            if (staza == null || !staza.Any())
            {
                throw new StazeException("Staza ne postoji!");
            }

            if (stazeKorisnik == null)
            {
                var korisnik = new KorisniciStaze() { KorisniciId = userId, StazeId = id };

                await stazaKorisnikDB.AddAsync(korisnik);
            }
            else
            {
                stazaKorisnikDB.Remove(stazeKorisnik);
            }

            await _context.SaveChangesAsync();

            return true;
        }

        static object lockObj = new object();
        static MLContext? mlContextInstance = null;
        static ITransformer? trainedModel = null;

        public PagedResult<Model.Staze> StazeRecommenderSystem(int userId)
        {
            if (userId == null)
            {
                throw new StazeException("Potreban je userId!");
            }

            var rezervacijeList = _context.Rezervacijes
                .Include(r => r.Staza)
                .ToList();

            if (rezervacijeList.Count < 3) //Potrebno je najmanje 3 rezervacije za preporuku staza!
            {
                var resulter = new PagedResult<Model.Staze>() 
                { 
                    Count = 0,
                    Result = []
                };

                return resulter;
            }

            lock (lockObj)
            {
                if (mlContextInstance == null)
                {
                    mlContextInstance = new MLContext();

                    var trainingData = new List<StazeEntry>();

                    var stazeBrojOsoba = rezervacijeList
                        .GroupBy(r => r.StazaId)
                        .Select(group => new
                        {
                            StazaId = group.Key,
                            TotalPeople = group.Sum(r => r.BrojOsoba)
                        }).ToList();

                    foreach (var staza in stazeBrojOsoba)
                    {
                        trainingData.Add(new StazeEntry
                        {
                            StazaId = (uint)staza.StazaId,
                            TotalPeople = (float)staza.TotalPeople
                        });
                    }

                    if (!trainingData.Any())
                    {
                        throw new StazeException("Podaci za trening su prazni!");
                    }

                    var mlTrainData = mlContextInstance.Data.LoadFromEnumerable(trainingData);
                    var dataSplit = mlContextInstance.Data.TrainTestSplit(mlTrainData, testFraction: 0.2);

                    var options = new MatrixFactorizationTrainer.Options
                    {
                        MatrixColumnIndexColumnName = nameof(StazeEntry.StazaId),
                        MatrixRowIndexColumnName = nameof(StazeEntry.StazaId),
                        LabelColumnName = "TotalPeople",
                        LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass,
                        Alpha = 0.01,
                        Lambda = 0.025
                    };

                    var trainer = mlContextInstance.Recommendation().Trainers.MatrixFactorization(options);
                    trainedModel = trainer.Fit(dataSplit.TrainSet);
                    if (trainedModel == null)
                    {
                        throw new InvalidOperationException("Model nije uspješno treniran.");
                    }
                }
            }

            var predictionResults = new List<Tuple<Database.Staze, float>>();
            var allStaze = _context.Stazes.Include(x => x.Tezina).ToList();

            foreach (var staza in allStaze)
            {
                var predictionEngine = mlContextInstance.Model.CreatePredictionEngine<StazeEntry, StazePrediction>(trainedModel);
                var prediction = predictionEngine.Predict(new StazeEntry
                {
                    StazaId = (uint)staza.Id,
                    TotalPeople = staza.Rezervacijes.Sum(r => r.BrojOsoba)
                });

                predictionResults.Add(new Tuple<Database.Staze, float>(staza, prediction.Score));
            }

            var top3Recommendations = predictionResults.OrderByDescending(x => x.Item2)
                .Select(x => x.Item1)
                .Take(3)
                .ToList();

            var korisniciStazes = _context.KorisniciStazes.Where(x => x.KorisniciId == userId);

            var top3Staze = _mapper.Map<List<Model.Staze>>(top3Recommendations);

            foreach (var korisniciStaze in korisniciStazes)
            {
                foreach (var staza in top3Staze)
                {
                    if (staza.Id == korisniciStaze.StazeId)
                    {
                        staza.Favourite = true;
                    }
                }
            }

            var result = new PagedResult<Model.Staze>
            {
                Result = top3Staze,
                Count = top3Staze.Count,
            };

            return result;
        }

        public class StazeEntry
        {
            [KeyType(count: 10)]
            public uint StazaId { get; set; }
            public float TotalPeople { get; set; }
        }

        public class StazePrediction
        {
            public float Score { get; set; }
        }
    }
}
