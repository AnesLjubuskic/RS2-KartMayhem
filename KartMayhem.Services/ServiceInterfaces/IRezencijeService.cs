using KartMayhem.Model;
using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IRezencijeService : IBaseCRUDService<Rezencije, BaseSearchObject, RezencijaInsertRequest, object>
    {
    }
}
