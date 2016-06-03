using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using TrafficVisualization.Entities;

namespace TrafficVisualization.DbContexts
{
    public class TruckDbContext : DbContext
    {
        public TruckDbContext()
            : base("TruckDemoConnString")
        {

        }
     
        public DbSet<TruckData> TruckDatas { get; set; }
        public DbSet<SysConfiguration> Configurations { get; set; }
    }
}