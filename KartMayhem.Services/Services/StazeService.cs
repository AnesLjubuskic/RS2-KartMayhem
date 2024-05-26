﻿using AutoMapper;
using KartMayhem.Model.Exception;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using KartMayhem.Services.Database;
using KartMayhem.Services.ServiceInterfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.Services
{
    public class StazeService : BaseCRUDService<Model.Staze, Database.Staze, StazeSearchObject, StazeUpsertRequest, StazeUpsertRequest>, IStazeService
    {
        public StazeService(KartMayhemContext context, IMapper mapper) : base(context, mapper)
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

        public override Task BeforeInsert(Staze entity, StazeUpsertRequest insert)
        {
            

            entity.IsActive = true;

            //var pictureValue = _context.Tezines.Find(insert.TezinaId);
            //
            //if (pictureValue == null)
            //{
            //    throw new StazeException("Tezina id nije validna!");
            //}
            //
            //entity.Slika = pictureValue.Slika;
            
            return base.BeforeInsert(entity, insert);
        }

        public override IQueryable<Staze> AddFilter(IQueryable<Staze> query, StazeSearchObject? search = null)
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

        public override IQueryable<Staze> AddInclude(IQueryable<Staze> query, StazeSearchObject? search = null)
        {
            var includeQuery = base.AddInclude(query, search);
            includeQuery = includeQuery.Include(x => x.Tezina);

            return includeQuery;
        }
    }
}
