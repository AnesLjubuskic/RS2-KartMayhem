using KartMayhem.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KartMayhem.Services.ServiceInterfaces
{
    public interface IEmailSenderService
    {
        public void SendingObject(RezervacijeMail obj);
    }
}
