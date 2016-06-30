using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;

namespace TrafficVisualization.App_Start
{
    public class BundleConfig
    {

        public static void RegisterBundles(BundleCollection bundles)
        {

            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
                    "~/Scripts/jquery-ui-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrapjs").Include(
                     "~/Scripts/bootstrap.min.js",
                     "~/Scripts/bootstrap-switch.min.js",
                     "~/Scripts/bootstrap.tour.js",
                     "~/Scripts/bootstrap-tour.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                    "~/Scripts/modernizr-latest.js"));

            bundles.Add(new ScriptBundle("~/bundles/retaildemojs").Include(
                    "~/Scripts/retaildemo.js"));

            bundles.Add(new ScriptBundle("~/bundles/highchartsjs").Include(
                    "~/Scripts/Highcharts-4.0.1/js/highcharts.js"));

            bundles.Add(new StyleBundle("~/bundles/bootstrap").Include(
                "~/Content/bootstrap.min.css",
                "~/Content/bootstrap-switch.min.css",
                "~/Content/bootstrap-tour.css",
                "~/Content/bootstrap-tour.min.css"));

            bundles.Add(new StyleBundle("~/bundles/bootstraptheme").Include(
                "~/Content/bootstrap-theme.css"));

            bundles.Add(new StyleBundle("~/bundles/appcss").Include(
                "~/Content/custom.css"));

            BundleTable.EnableOptimizations = false;
        }
    }
}