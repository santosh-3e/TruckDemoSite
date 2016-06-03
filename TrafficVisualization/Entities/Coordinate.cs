using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TrafficVisualization.Entities
{
    public class Coordinate
    {
        
        public string TruckID { get; set; }
        public string SensorId { get; set; }
        public string Latitude { get; set; }
        public string Longitude { get; set; }
        public string Timestamp { get; set; }
        public Int32 Temperature { get; set; }
        public Int32 Oxygen { get; set; }
        public Int32 Moisture { get; set; }
        public Int32 Pressure { get; set; }
        public Int32 Ethylene { get; set; }
        public Int32 Co2 { get; set; }
        public string Predictor { get; set; }
        public string Address { get; set; }
        public string ScoreLabel { get; set; }

        //public Int32 co2_min { get; set; }
        //public Int32 co2_max { get; set; }
        //public Int32 oxygen_min { get; set; }
        //public Int32 oxygen_max { get; set; }
        //public Int32 moisture_min { get; set; }
        //public Int32 moisture_max { get; set; }
        //public Int32 pressure_min { get; set; }
        //public Int32 pressure_max { get; set; }
        //public Int32 ethylene_min { get; set; }
        //public Int32 ethylene_max { get; set; }
        //public Int32 temp_min { get; set; }
        //public Int32 temp_max { get; set; }

        //public List<Int32> co2_list { get; set; }
        //public List<Int32> oxygen_list { get; set; }
        //public List<Int32> moisture_list { get; set; }
        //public List<Int32> ethylene_list { get; set; }
        //public List<Int32> pressure_list { get; set; }
        //public List<Int32> temp_list { get; set; }


        public double AvgTemperature { get; set; }
        public double AvgOxygen { get; set; }
        public double AvgMoisture { get; set; }
        public double AvgPressure { get; set; }
        public double AvgEthylene { get; set; }
        public double AvgCo2 { get; set; }

    }
}