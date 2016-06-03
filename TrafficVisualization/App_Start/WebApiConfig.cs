using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace TrafficVisualization.App_Start
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {

            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{action}/{id}",
                defaults: new { action="Index", id = RouteParameter.Optional }
            );

          
            //config.Routes.MapHttpRoute(
            //    name: "custcodee",
            //    routeTemplate: "api/{controller}/{custid}/custcode",
            //    defaults: new { id = RouteParameter.Optional }
            //);
        }
    }
}