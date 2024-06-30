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
                context.ModelState.AddModelError("rezervacijeError", context.Exception.Message);
                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
            }

            else if (context.Exception is StazeException)
            {
                context.ModelState.AddModelError("stazeError", context.Exception.Message);
                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
            }

            else if (context.Exception is RezencijeException)
            {
                context.ModelState.AddModelError("rezencijeError", context.Exception.Message);
                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
            }

            else if (context.Exception is FeedbackException)
            {
                context.ModelState.AddModelError("feedbackError", context.Exception.Message);
                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
            }

            var errorsDictionary = context.ModelState.Where(m => m.Value.Errors.Count > 0).ToDictionary(m => m.Key, m => m.Value.Errors.Select(e => e.ErrorMessage).ToList());
            context.Result = new ObjectResult(new { Errors = errorsDictionary });
        }
    }
}
