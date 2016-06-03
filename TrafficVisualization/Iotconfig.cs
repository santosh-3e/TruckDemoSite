namespace TrafficVisualization
{
    public class Iotconfig
    {
        public string EventHubName { get; set; }
        public string ServiceBusNameSpace { get; set; }
        public string SharedAccessKey { get; set; }
        public string SharedAccessKeyName { get; set; }

        public bool IsProcessStarted { get; set; }
        public bool StartProcess { get; set; }

        public bool IsPositiveFeeds { get; set; }   

    }
}