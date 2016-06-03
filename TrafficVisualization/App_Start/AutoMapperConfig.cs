using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AutoMapper;
using TrafficVisualization.Entities;

namespace TrafficVisualization.App_Start
{
    public class AutoMapperConfig
    {
        public static void Map()
        {
            Mapper.CreateMap<Coordinate, TruckData>();
            Mapper.CreateMap<TruckData, Coordinate>();
        }
    }
}