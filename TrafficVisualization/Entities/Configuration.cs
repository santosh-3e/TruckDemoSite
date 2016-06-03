using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TrafficVisualization.Entities
{
    public class SysConfiguration
    {
        public Int64 Id { get; set; }
        
        public bool IsStart { get; set; }
        public bool IsPositive { get; set; }    
    }
}