using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Configuration;
using System.Web.Http;
using DotNet.Highcharts;
using DotNet.Highcharts.Enums;
using DotNet.Highcharts.Helpers;
using DotNet.Highcharts.Options;
using System.Threading.Tasks;
using Newtonsoft.Json;
using TrafficVisualization.DbContexts;
using TrafficVisualization.Entities;

namespace TrafficVisualization
{
    public class RealTimeDashboardController : ApiController
    {
        HBaseReader hbase = new HBaseReader();

        [HttpGet]
        public string StartDataFeeder(string process)
        {
            var configIotconfig = JsonConvert.DeserializeObject<Iotconfig>(process);
            var db = new TruckDbContext();
            var entry = db.Configurations.FirstOrDefault();
            if (entry == null)
            {
                return "";
            }
            if (configIotconfig.StartProcess)
            {
                db.Database.ExecuteSqlCommand("TRUNCATE TABLE [TruckDatas]");
                entry.IsStart = true;
                entry.IsPositive = configIotconfig.IsPositiveFeeds;
            }
            else
            {
                entry.IsStart = false;
                entry.IsPositive = configIotconfig.IsPositiveFeeds;
            }
            db.SaveChanges();
            return "";
        }

        [HttpGet]
        public string GetCoordinate(string query, string type)
        {
            int cnt = Convert.ToInt32(query);
            return hbase.GetCoordinatesAsync(cnt, type);
        }
    }
}
