using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Web.Http.Cors;

namespace WebApplication.ApiAdo
{
    public static class WebApiConfig

    {
        public static void Register(HttpConfiguration config)
        {

            var cors = new EnableCorsAttribute("http://127.0.0.1:5500", "*", "GET,POST,PUT,DELETE");

            config.EnableCors(cors);

            // Configuración y servicios de API web


            // Rutas de API web
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
         name: "ApiAction",
         routeTemplate: "api/{controller}/{action}/{id}",
         defaults: new { id = RouteParameter.Optional }
     );



            config.Formatters.JsonFormatter.SupportedMediaTypes.
            Add(new System.Net.Http.Headers.MediaTypeHeaderValue("text/html"));


        }
    }
}
