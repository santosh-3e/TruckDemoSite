<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bingmap.aspx.cs" Inherits="TrafficVisualization.bingmap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-2.1.1.min.js"></script>
     <script type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"></script>
    <script type="text/javascript">
        var map = null;
        var directionsManager;

        $(document).ready(function () {
            
            getMap();
            createDirections();
        });

        function getMap() {
            map = new Microsoft.Maps.Map(document.getElementById('myMap'), {
                credentials: 'Ap-y7iQWyP7PrWGIEENR3mOY8bQKwBi_9cc7rzAkPku1a6_1f6HMLleBQZoz5mXa',
                showDashboard: false,
                enableSearchLogo: false,
                mapTypeId: Microsoft.Maps.MapTypeId.road,
            });
        }

        function createDirectionsManager() {
            if (!directionsManager) {
                directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
            }
            directionsManager.resetDirections();
        }

        function addWaypoint() {
            if (!directionsManager) { createDirectionsManager(); }
            if (directionsManager.getAllWaypoints().length < 2) {
                directionsManager.resetDirections();
                var startWaypoint = new Microsoft.Maps.Directions.Waypoint({ address: 'Seattle, WA', location: new Microsoft.Maps.Location(32.54509, -117.033257) });
                directionsManager.addWaypoint(startWaypoint);
                var endWaypoint = new Microsoft.Maps.Directions.Waypoint({ address: 'Tacoma, WA', location: new Microsoft.Maps.Location(32.64061, -117.055344), icon: 'assets/icons/truck_black_1.png' });
                directionsManager.addWaypoint(endWaypoint);
            }
            // Insert a waypoint
        //    directionsManager.addWaypoint(new Microsoft.Maps.Directions.Waypoint({ address: 'Issaquah, WA', location: new Microsoft.Maps.Location(47.530094, -122.033798) }), 1);
            // Set the element in which the itinerary will be rendered
          //  directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('directionsItinerary') });
            directionsManager.calculateDirections();
        }

        function createDirections() {
            if (!directionsManager) {
                Microsoft.Maps.loadModule('Microsoft.Maps.Directions', { callback: addWaypoint });
            }
            else {
                addWaypoint();
            }
        }
      </script>
</head>
<body>
    <form id="form1" runat="server">
      <div id='myMap' style="position:relative; width:400px; height:400px;"></div>
      <div>
         <input type="button" value="InsertWaypoint" onclick="createDirections();" />
      </div>
      <div id='directionsItinerary'> </div> 

    </form>
</body>
</html>
