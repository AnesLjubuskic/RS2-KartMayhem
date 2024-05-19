using KartMayhem.Model.Exception;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System.Net;

namespace KartMayhem.Filters
{
    public class ErrorFilter : ExceptionFilterAttribute
    {
        public override void OnException(ExceptionContext context)
        {
            if (context.Exception is UserException)
            {
                context.ModelState.AddModelError("userError", context.Exception.Message);
                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
            }

            else if (context.Exception is RezervacijeException) 
            {
                context.ModelState.AddModelError(((RezervacijeException)context.Exception).Title, context.Exception.Message);
                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
            }
            
            var errorsDictionary = context.ModelState.Where(m => m.Value.Errors.Count > 0).ToDictionary(m => m.Key, m => m.Value.Errors.Select(e => e.ErrorMessage).ToList());
            context.Result = new ObjectResult(new { Errors = errorsDictionary });
        }
    }
}
