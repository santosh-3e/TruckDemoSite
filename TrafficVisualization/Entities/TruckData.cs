using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TrafficVisualization.Entities
{
    public class TruckData
    {
        public Int64 Id { get; set; }
        public string TruckID { get; set; }
        public string SensorId { get; set; }
        public string Latitude { get; set; }
        public string Longitude { get; set; }
        public DateTime Timestamp { get; set; }
        public Int32 Temperature { get; set; }
        public Int32 Oxygen { get; set; }
        public Int32 Moisture { get; set; }
        public Int32 Pressure { get; set; }
        public Int32 Ethylene { get; set; }
        public Int32 Co2 { get; set; }
        public string Predictor { get; set; }
        public string ScoreLabel { get; set; }
    }
}