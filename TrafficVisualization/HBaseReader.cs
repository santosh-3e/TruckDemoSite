using AutoMapper;
using Microsoft.HBase.Client;
using Newtonsoft.Json;
using org.apache.hadoop.hbase.rest.protobuf.generated;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using TrafficVisualization.DbContexts;
using TrafficVisualization.Entities;
using WebGrease.Css.Extensions;

namespace TrafficVisualization
{
    public class HBaseReader
    {
        // The constructor
        public HBaseReader()
        {
          
        }

        // Query Tweets sentiment data from the HBase table asynchronously 
        public string GetCoordinatesAsync(int count,string type)
        {
            List<Coordinate> sendresuList = new List<Coordinate>();
            TruckDbContext db=new TruckDbContext();
            List<string> distincttrucks = new List<string>();
            db.TruckDatas.Select(c => c.TruckID).Distinct().ToArray().ForEach(distincttrucks.Add);

            List<TruckData> truckdatas=new List<TruckData>();
            foreach (var truck in distincttrucks)
            {
                var data = db.TruckDatas.OrderByDescending(c => c.Timestamp).Where(c => c.TruckID == truck.ToString() && c.ScoreLabel==type).Take(1).ToArray();
                var PrevTenRecs = db.TruckDatas.OrderByDescending(c => c.Timestamp).Where(c => c.TruckID == truck.ToString() && c.ScoreLabel == type).Take(10).ToArray();
                
                sendresuList.AddRange(Mapper.Map<TruckData[], Coordinate[]>(data));
                int currentTruckIndex = sendresuList.Count - 1;
                sendresuList[currentTruckIndex].AvgCo2 = PrevTenRecs.Average(d => d.Co2);
                sendresuList[currentTruckIndex].AvgEthylene = PrevTenRecs.Average(d => d.Ethylene);
                sendresuList[currentTruckIndex].AvgMoisture = PrevTenRecs.Average(d => d.Moisture);
                sendresuList[currentTruckIndex].AvgOxygen = PrevTenRecs.Average(d => d.Oxygen);
                sendresuList[currentTruckIndex].AvgPressure = PrevTenRecs.Average(d => d.Pressure);
                sendresuList[currentTruckIndex].AvgTemperature = PrevTenRecs.Average(d => d.Temperature);
            }

            return JsonConvert.SerializeObject(sendresuList);
        }

    }
}