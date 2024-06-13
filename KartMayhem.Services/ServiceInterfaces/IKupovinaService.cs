using KartMayhem.Model.RequestObjects;
using KartMayhem.Model.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IKupovinaService : IBaseCRUDService<Model.Kupovina, BaseSearchObject, KupovinaInsertRequest, KupovinaInsertRequest>
    {
        IEnumerable<Model.Kupovina> GetByKorisnikId(int id);
        Model.Kupovina Plati(KupovinaInsertRequest request);
    }
}
