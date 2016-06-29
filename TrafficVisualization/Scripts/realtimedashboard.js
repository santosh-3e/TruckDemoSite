var counter = 0;
var map = null;
var lastZoomLevel = 15;
var directionsManager = null;

var currentTruck;
var IsFetchingTruckData = false;
var truckEmpty = {
    ProductName: null,
    Trucknumber: null,
    ScoreLabel: null,
    Drivername: null,
    Driverid: null,
    Routename: null,
    Routenumber: null,
    Graph_color: null,
    StartLat: null,
    StartLong: null,
    EndLat: null,
    EndLong: null,
    co2: [],
    o2: [],
    moisture: [],
    ethylene: [],
    pressure: [],
    temperature: [],
    geolLocations: []
};

//initialize all four truck objects in local
var truck1 = {
    ProductName: "Sushi",
    Trucknumber: 1,
    ScoreLabel: 1,
    Drivername: "Patty M",
    Driverid: "001",
    Routename: "i-5",
    Routenumber: "i-5",
    Graph_color: "#ff7f0e",
    StartLat: 0,
    StartLong: 0,
    EndLat: 0,
    EndLong: 0,
    co2: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    o2: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    moisture: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ethylene: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    pressure: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    temperature: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    geolLocations: []
};

var truck2 = {
    ProductName: "Vegetables",
    Trucknumber: 2,
    ScoreLabel: 1,
    Drivername: "Mark D",
    Driverid: "002",
    Routename: "i-78",
    Routenumber: "i-78",
    Graph_color: "#00FFFF",
    StartLat: 0,
    StartLong: 0,
    EndLat: 0,
    EndLong: 0,
    co2: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    o2: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    moisture: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ethylene: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    pressure: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    temperature: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    geolLocations: []
};

var truck3 = {
    ProductName: "Fruits",
    Trucknumber: 3,
    ScoreLabel: 1,
    Drivername: "Scott J",
    Driverid: "003",
    Routename: "i-90",
    Routenumber: "i-90",
    Graph_color: "#FF33CC",
    StartLat: 0,
    StartLong: 0,
    EndLat: 0,
    EndLong: 0,
    co2: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    o2: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    moisture: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ethylene: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    pressure: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    temperature: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    geolLocations: []
};

var truck4 = {
    ProductName: "Dried fruits",
    Trucknumber: 4,
    ScoreLabel: 1,
    Drivername: "Andrews P",
    Driverid: "004",
    Routename: "i-99",
    Routenumber: "i-99",
    Graph_color: "#FF0000",
    StartLat: 0,
    StartLong: 0,
    EndLat: 0,
    EndLong: 0,
    co2: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    o2: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    moisture: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ethylene: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    pressure: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    temperature: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    geolLocations: []
};

var datafeeder = {
    IsProcessStarted: false,
    StartProcess: false,
    IsPositiveFeeds: false
};
var StartRealTimeDashboard = false;
var counter = 0;
$(document).ready(function () {
    $("#mystartbtn").hide();
    $("#adversebutton").hide();

    // Instance the tour
    $("#StartDiv").show();
    $("#cmdSTartDemo").on("click", function () {
        $("#DemoDiv").show();
        $("#StartDiv").hide();
        $("#mystartbtn").show();
        $("#adversebutton").show();
       

        $('#resetDashboard').bootstrapSwitch("state", true, true);
        //Start the tour
        setTimeout(function () {
            tour.start();
        }, 2000);
      
        return false;
    });

    var tour1 = new Tour({
        steps: [
            {
                element: "#divSafe",
                title: "Predictions Based On Sensor Readings",
                content: "Machine Learning scoring of data in real time to determine if the food would go bad in next 4 hours",
                placement: "bottom",
                onNext: function () {
                    setTimeout(function() {
                        tour1.end();
                    },500);
                }
            },
             {
                 element: "#divSafe",
                 title: "Predictions Based On Sensor Readings",
                 content: "Machine Learning scoring of data in real time to determine if the food would go bad in next 4 hours",
                 placement: "bottom"
             }
        ],
        animation: true,
        container: "body",
        backdrop: false,
        storage: false,
        template: "<div class='popover tour'><div class='arrow'></div><h3 class='popover-title'></h3><div class='popover-content'></div><div class='popover-navigation'><button class='btn btn-info btn-xs' data-role='next'>End Tour</button></div></div>"
    });


    var tour = new Tour({
        steps: [
        {
            element: "#mystartbtn",
            title: "Start/Stop Demo",
            content: "Start/Stop the demo by clicking here.",
            placement: "bottom",
        },
        {
            element: "#truck1_link",
            title: "Truck Information",
            content: "Each truck is carrying a different type of perishable food.",
            placement: "bottom"
        },
        {
            element: ".mylocationdiv",
            title: "Current Location Information",
            content: "Latitude & longitude information extracted from each truck’s data is used to compute its geographical location in real time."
        },
        {
            element: "#chart3",
            title: "Truck Sensor Details",
            html: "true",
            content: "Six different types of sensors installed in the trucks that display their data in real time.",
            placement: "top"
        },
        {
                element: "#divSafe",
                title: "Predictions Based On Sensor Readings",
                content: "Machine learning algorithms score the six types of sensor data in real time to determine perishability of each kind of food.",
                placement: "bottom",
                onNext: function() {
                $('#btnChangeData').bootstrapSwitch("state", true, true);
            }
        },
        {
            element: "#adversebutton",
            title: "Control Positive or Adverse condition",
            content: "Send data for good or adverse or conditions by clicking here.",
            placement: "bottom",
            onNext: function () {
                tour.end();
                tour1.init();
                tour1.start();
            }
        },
        {
            element: "#divSafe222",
            title: "Predictions Based On Sensor Readings",
            content: "Machine learning algorithms have determined in real time that the food in a particular truck will perish in next 4 hours. ",
            placement: "bottom"
        }
        ],
        animation: true,
        container: "body",
        backdrop: false,
        storage: false,
        template: "<div class='popover tour'> <div class='arrow'></div><h3 class='popover-title'></h3><div class='popover-content'></div><div class='popover-navigation'><button class='btn btn-info btn-xs' style='margin-bottom:5px' data-role='next'>Next »</button></div></div>"
    });
    // Initialize the tour
    tour.init();

 
   // try {
    $("[btn='toggleBtn']").bootstrapSwitch();
    $('#resetDashboard').on('switchChange.bootstrapSwitch', function (event, state) {
        // Start Stop Button Event
        if ($(this).attr("eventfor") === "2") {
            //control data feeding
            if (state) {
                // console.log('Starting');
                datafeeder.StartProcess = true;
                datafeeder.IsProcessStarted = false;
            } else {
                //console.log('Stoppig');
                datafeeder.StartProcess = false;
                datafeeder.IsProcessStarted = false;
                
                truck1.geolLocations = [];
                truck2.geolLocations = [];
                truck3.geolLocations = [];
                truck4.geolLocations = [];
            }

            if ($('#btnChangeData').bootstrapSwitch("state")) {
                datafeeder.IsPositiveFeeds = false;
            } else {
                datafeeder.IsPositiveFeeds = true;
            }
            //console.log(JSON.stringify(datafeeder));
            $.ajax({
                url: "/api/Realtimedashboard/StartDataFeeder?process=" + JSON.stringify(datafeeder)
            }).done(function () {
                //showMessage("Data feeder process " + (datafeeder.StartProcess ? "Started" : "Stopped"));
            });

            if (state) {
                StartRealTimeDashboard = true;
            } else {
                StartRealTimeDashboard = false;
            }
        }

        if ($(this).attr("eventfor") == "1") // DOM elem  ent
        {
            //Control data type
            if ($('#btnStartFeed').bootstrapSwitch('state')) {
                if (!state) {
                    //console.log('Positive');
                    datafeeder.StartProcess = true;
                    datafeeder.IsProcessStarted = true;
                    datafeeder.IsPositiveFeeds = true;
                } else {
                    //console.log('Negative');
                    datafeeder.StartProcess = true;
                    datafeeder.IsProcessStarted = true;
                    datafeeder.IsPositiveFeeds = false;
                }
                //console.log(datafeeder);
                $.ajax({
                    url: "/api/Realtimedashboard/StartDataFeeder?process=" + JSON.stringify(datafeeder)
                }).done(function () {
                    showMessage("Event Type changed to " + (datafeeder.IsPositiveFeeds ? "Positive" : "Negative"));
                });
            } else {
                if (!state) {
                    //console.log('Positive');
                    datafeeder.IsPositiveFeeds = true;
                } else {
                    //console.log('Negative');
                    datafeeder.IsPositiveFeeds = false;
                }
            }
        }
    });
    
    //initialise map object when page loaded
    getMap();
  
    //Do call to API to get all trucks data from hbase and repeat call to api after interval laps
    var interval = 1000;
    
    setInterval(function () {
        if (StartRealTimeDashboard) {
            try {
                if (IsFetchingTruckData == false) {
                    CallHBaseApi();
                }
            } catch (errorMessage) {
                //console.log('Error : ' + errorMessage);
            }
        }
    }, interval);
});

function showMessage(message) {

    $.growl({
        icon: "glyphicon glyphicon-check",
        title: " Activity : ",
        message: message
    }, {
        type: "warning",
        animate: {
            enter: 'animated fadeInRight',
            exit: 'animated fadeOutRight'
        },
        offset: {
            x: 15,
            y: 60
        }
    }
    );
}

function CallHBaseApi() {

    var IsPositiveFeeds = "1";
    if ($('#btnChangeData').bootstrapSwitch("state")) {
        IsPositiveFeeds = "1";
    } else {
        IsPositiveFeeds = "0";
    }

    IsFetchingTruckData = true;
    $.ajax({
        url: "/api/Realtimedashboard/GetCoordinate?query=" + counter + "&type=" + IsPositiveFeeds,
        dataType: "json"
    }).success(function (data) {
        var data1 = jQuery.parseJSON(data);
        counter++;
        IsFetchingTruckData = false;
        $.each(data1, function (index, d) {
           
            try {
                
                if (d.TruckID === "946891911") {
                   
                    if (truck1.StartLat === 0) {
                        truck1.StartLat = d.Latitude;
                        truck1.StartLong = d.Longitude;
                    }
                    truck1.EndLat = d.Latitude;
                    truck1.EndLong = d.Longitude;

                    truck1.o2.shift();
                    truck1.o2.push(d.Oxygen);

                    truck1.co2.shift();
                    truck1.co2.push(d.Co2);

                    truck1.moisture.shift();
                    truck1.moisture.push(d.Moisture);

                    truck1.ethylene.shift();
                    truck1.ethylene.push(d.Ethylene);

                    truck1.pressure.shift();
                    truck1.pressure.push(d.Pressure);

                    truck1.temperature.shift();
                    truck1.temperature.push(d.Temperature);

                    var isFound = false;
                    $.each(truck1.geolLocations, function (index, value) {
                        if (value.latitude == d.Latitude && value.longitude == d.Longitude) {
                            isFound = true;
                        }
                    });
                    if (!isFound) {
                        truck1.geolLocations.push(new Microsoft.Maps.Location(truck1.EndLat, truck1.EndLong));
                    }

                    currentTruck = truck1;
                }

                if (d.TruckID === "273593411") {
                    if (truck2.StartLat === 0) {
                        truck2.StartLat = d.Latitude;
                        truck2.StartLong = d.Longitude;
                    }
                    truck2.EndLat = d.Latitude;
                    truck2.EndLong = d.Longitude;

                    truck2.o2.shift();
                    truck2.o2.push(d.Oxygen);

                    truck2.co2.shift();
                    truck2.co2.push(d.Co2);

                    truck2.moisture.shift();
                    truck2.moisture.push(d.Moisture);

                    truck2.ethylene.shift();
                    truck2.ethylene.push(d.Ethylene);

                    truck2.pressure.shift();
                    truck2.pressure.push(d.Pressure);

                    truck2.temperature.shift();
                    truck2.temperature.push(d.Temperature);

                    isFound = false;

                    $.each(truck2.geolLocations, function(index, value) {
                        if (value.latitude === d.Latitude && value.longitude === d.Longitude) {
                            isFound = true;
                        }
                    });
                    if (!isFound) {
                        truck2.geolLocations.push(new Microsoft.Maps.Location(truck2.EndLat, truck2.EndLong));
                    }
                    currentTruck = truck2;
                }

                if (d.TruckID === "58534368") {
                    if (truck3.StartLat === 0) {
                        truck3.StartLat = d.Latitude;
                        truck3.StartLong = d.Longitude;
                    }
                    truck3.EndLat = d.Latitude;
                    truck3.EndLong = d.Longitude;

                    truck3.o2.shift();
                    truck3.o2.push(d.Oxygen);

                    truck3.co2.shift();
                    truck3.co2.push(d.Co2);

                    truck3.moisture.shift();
                    truck3.moisture.push(d.Moisture);

                    truck3.ethylene.shift();
                    truck3.ethylene.push(d.Ethylene);

                    truck3.pressure.shift();
                    truck3.pressure.push(d.Pressure);

                    truck3.temperature.shift();
                    truck3.temperature.push(d.Temperature);

                    isFound = false;

                    $.each(truck3.geolLocations, function(index, value) {
                        if (value.latitude === d.Latitude && value.longitude === d.Longitude) {
                            isFound = true;
                        }
                    });
                    if (!isFound) {
                        truck3.geolLocations.push(new Microsoft.Maps.Location(truck3.EndLat, truck3.EndLong));
                    }

                    currentTruck = truck3;
                }
                if (d.TruckID == "181390302") {
                    if (truck4.StartLat == 0) {
                        truck4.StartLat = d.Latitude;
                        truck4.StartLong = d.Longitude;
                    }
                    truck4.EndLat = d.Latitude;
                    truck4.EndLong = d.Longitude;

                    truck4.o2.shift();
                    truck4.o2.push(d.Oxygen);

                    truck4.co2.shift();
                    truck4.co2.push(d.Co2);

                    truck4.moisture.shift();
                    truck4.moisture.push(d.Moisture);

                    truck4.ethylene.shift();
                    truck4.ethylene.push(d.Ethylene);

                    truck4.pressure.shift();
                    truck4.pressure.push(d.Pressure);

                    truck4.temperature.shift();
                    truck4.temperature.push(d.Temperature);

                    isFound = false;

                    $.each(truck4.geolLocations, function(index, value) {
                        if (value.latitude === d.Latitude && value.longitude === d.Longitude) {
                            isFound = true;
                        }
                    });
                    if (!isFound) {
                        truck4.geolLocations.push(new Microsoft.Maps.Location(truck4.EndLat, truck4.EndLong));
                    }
                    currentTruck = truck4;
                }
                if (currentTruck.Trucknumber == $("#truck").val()) {

                    var locstart = new Microsoft.Maps.Location(currentTruck.StartLat, currentTruck.StartLong);
                    var locend = new Microsoft.Maps.Location(currentTruck.EndLat, currentTruck.EndLong);
                    // createDirections();

                    var pinstart = new Microsoft.Maps.Pushpin(map.getCenter());
                    var pinend = new Microsoft.Maps.Pushpin(map.getCenter(), { icon: 'assets/icons/truck_black_' + currentTruck.Trucknumber + '.png' });

                    pinstart.setLocation(locstart);
                    pinend.setLocation(locend);

                    if (currentTruck.geolLocations.length > 2) {
                        $.each(currentTruck.geolLocations, function(index, geoloc) {
                            try {
                                if (locstart.latitude >= locend.latitude) {
                                    //dont take any geolocation less than this end point
                                    if (geoloc.latitude < locend.latitude) {
                                        currentTruck.geolLocations.splice(index, 1);
                                    }
                                } else {
                                    //dont take any geolocation greater than this end point
                                    if (geoloc.latitude > locend.latitude) {
                                        currentTruck.geolLocations.splice(index, 1);
                                    }
                                }
                            } catch(error) {

                            }
                        });
                    }
                  
                    var line = new Microsoft.Maps.Polyline(currentTruck.geolLocations.sort(function(obj1, obj2) { return obj1.latitude - obj2.latitude; }));
                    map.entities.clear(); // = [];

                    map.setView({ center: locend, zoom: lastZoomLevel });

                    map.entities.push(line);
                    map.entities.push(pinstart);
                    map.entities.push(pinend);

                    Microsoft.Maps.Events.addHandler(map, 'viewchangeend', viewChanged);

                    displayDownCharts(d);
                    $('#truck_det').html(detailsInfo(d));
                }

            } catch (error) {
                showMessage('Error in schema received from hbase. Unable to show realtime dashboard.');
                //console.log('Error in schema received from hbase. Unable to show realtime dashboard.');
            }
        });
    }).error(function () {
        //showMessage('Please check hbase cluster connection settings...');
        IsFetchingTruckData = false;
        //console.log('Please check hbase cluster connection settings...');
    });
}

function getMap() {
    map = new Microsoft.Maps.Map(document.getElementById('truck_map'), {
        credentials: 'Ap-y7iQWyP7PrWGIEENR3mOY8bQKwBi_9cc7rzAkPku1a6_1f6HMLleBQZoz5mXa',
        showDashboard: false,
        enableSearchLogo: false,
        mapTypeId: Microsoft.Maps.MapTypeId.road,
    });
}

function viewChanged(e) {
    if (lastZoomLevel != map.getZoom()) {
        lastZoomLevel = map.getZoom();
    }
}

function displayDownCharts(d) {

    if ($('#truck').val() == currentTruck.Trucknumber) {
        var message = "<strong>" + currentTruck.ProductName + " would be <div  style='display:inline-block;background-color:#4B773A;color:white'>SAFE </div> for next 4 hours</strong>.<br>-Prediction is based on the current sensor readings.";
        var paneltype = 'panel-success';
        var headingwidth = 'col-md-6';
        var datagwidth = 'col-md-6';
        var background = "bg-success";
        if (d.ScoreLabel == 1) {
            paneltype = 'panel-danger';
            background = "bg-danger";
            message = "<strong>" + currentTruck.ProductName + " would <div style='display:inline-block;background-color:#DD0000;color:white'> PERISH  </div> in next 4 hours</strong>.<br>-Prediction is based on the current readings of six sensors data.";
        }

        $("#score_prediction")
            .html('<div class="panel ' + paneltype + '">'
                + '<div class="panel-heading"><b>Machine Learning based Predictions</b></div>'
                + '<div class="panel-body ' + background + '">'
                + '<div class="row"><div class="' + headingwidth + '"><b>Truck</b></div><div class="' + datagwidth + '">: ' + currentTruck.Trucknumber + '</div></div>'
                + '<div class="row"><div class="' + headingwidth + '"><b>Score Label</b></div><div class="' + datagwidth + '">: ' + d.ScoreLabel + '</div></div>'
                + '<div class="row"><div class="' + headingwidth + '"><b>Co2</b></div><div class="' + datagwidth + '">: ' + d.Co2 + '</div></div>'
                + '<div class="row"><div class="' + headingwidth + '"><b>Moisture</b></div><div class="' + datagwidth + '">: ' + d.Moisture + '</div></div>'
                + '<div class="row"><div class="' + headingwidth + '"><b>Oxygen</b></div><div class="' + datagwidth + '">: ' + d.Oxygen + '</div></div>'
                + '<div class="row"><div class="' + headingwidth + '"><b>Ethylene</b></div><div class="' + datagwidth + '">: ' + d.Ethylene + '</div></div>'
                + '<div class="row"><div class="' + headingwidth + '"><b>Pressure</b></div><div class="' + datagwidth + '">: ' + d.Pressure + '</div></div>'
                + '<div class="row"><div class="' + headingwidth + '"><b>Temperature</b></div><div class="' + datagwidth + '">: ' + d.Temperature + '</div></div>'
                + '<hr/><div class="row"><div class="col-md-12"><div id="divSafe"><span class="list-group-item"" style="background-color:#90B0D4; text-align:center" >' + message + '</span></div></div></div>'
                + '</div></div></div>'
                + '<div class="panel ' + paneltype + '">'
                + '<div class="panel-body ' + background + '">'
                + '<div class="row"><div class="col-md-12"><div id="maintanance">Predictive Maintenance results in huge cost savings for the Trucking industry.</br><a href="http://thirdeyecss.com/eyera">Learn More</a></div></div></div>'
            );

        nv.addGraph(graph(d));
    }

}



function graph(d) {

    var graphcolor = currentTruck.Graph_color;
    //temperature graph variable
    var temp_graph = [];

    for (var i = 0; i < 10; i++) {
        temp_graph.push({ x: i, y: currentTruck.temperature[i] });
    }

    var temp_graphvar = [
        {
            values: temp_graph,
            key: 'TEMPERATURE',
            color: graphcolor
        }
    ];
    
    var chart_temp = nv.models.lineChart()
        .margin({ left: 30 })  //Adjust chart margins to give the x-axis some breathing room.
        .useInteractiveGuideline(false)  //We want nice looking tooltips and a guideline!
        .transitionDuration(0)  //how fast do you want the lines to transition?
        .showLegend(true)       //Show the legend, allowing users to turn on/off line series.
        .showYAxis(true)        //Show the y-axis
        .showXAxis(false)        //Show the x-axis	             
    ;
    //chart_temp.forceY([d.temp_min, d.temp_min]);
    d3.select('#chart6 svg')
        .datum(temp_graphvar)
        .call(chart_temp);


    //co2 graph variable
    var co2_graph = [];


    for (i = 0; i < 10; i++) {
        co2_graph.push({ x: i, y: currentTruck.co2[i] });
    }

    var co2_graphvar = [
        {
            values: co2_graph,
            key: 'CO2',
            color: graphcolor
        }
    ];

    var chart_co2 = nv.models.multiBarChart()
        .transitionDuration(0)
        .reduceXTicks(false)   //If 'false', every single x-axis tick label will be rendered.
        .rotateLabels(0)      //Angle to rotate x-axis labels.
        .showControls(false)   //Allow user to switch between 'Grouped' and 'Stacked' mode.
        .groupSpacing(0.3); //Distance between each group of bars.

    chart_co2.xAxis
        .tickFormat(d3.format(',f'));

    chart_co2.yAxis
        .tickFormat(d3.format(',.1f'));
    //chart_co2.forceY([d.co2_min, d.co2_max]);
    d3.select('#chart1 svg')
        .datum(co2_graphvar)
        .call(chart_co2);


    //Pressure graph data
    var pressure_graph = [];

    for (i = 0; i < 10; i++) {
        pressure_graph.push({ x: i, y: currentTruck.pressure[i] });
    }
    var pressure_graphvar = [
        {
            values: pressure_graph,
            key: 'PRESSURE',
            color: graphcolor
        }
    ];

    var chart_pressure = nv.models.lineChart()

        .margin({ left: 30 })  //Adjust chart margins to give the x-axis some breathing room.
        .useInteractiveGuideline(false)  //We want nice looking tooltips and a guideline!
        .transitionDuration(0)  //how fast do you want the lines to transition?
        .showLegend(true)       //Show the legend, allowing users to turn on/off line series.
        .showYAxis(true)        //Show the y-axis
        .showXAxis(false)        //Show the x-axis	             
    ;
    chart_pressure.forceY([d.pressure_min, d.pressure_max]);
    d3.select("#chart5 svg")
        .datum(pressure_graphvar)
        .call(chart_pressure);

    //ethylene graph variable
    var ethylene_graph = [];


    for (i = 0; i < 10; i++) {
        ethylene_graph.push({ x: i, y: currentTruck.ethylene[i] });
    }
    var ethylene_graphvar = [
        {
            values: ethylene_graph,
            key: 'ETHYLENE',
            color: graphcolor
        }
    ];
    
    var chart_ethylene = nv.models.lineChart()

        .margin({ left: 30 })  //Adjust chart margins to give the x-axis some breathing room.
        .useInteractiveGuideline(true)  //We want nice looking tooltips and a guideline!
        .transitionDuration(0)  //how fast do you want the lines to transition?
        .showLegend(true)       //Show the legend, allowing users to turn on/off line series.
        .showYAxis(true)        //Show the y-axis
        .showXAxis(true)        //Show the x-axis	             
    ;
    // chart_ethylene.forceY([d.ethylene_min, d.ethylene_max]);
    d3.select('#chart4 svg')
        .datum(ethylene_graphvar)
        .call(chart_ethylene);

    //Moisture graph variable
    var moisture_graph = [];

    for (i = 0; i < 10; i++) {
        moisture_graph.push({ x: i, y: currentTruck.moisture[i] });
    }

    var mos_graphvar = [
        {
            values: moisture_graph,
            key: 'MOISTURE',
            color: graphcolor
        }
    ];

    var chart_mos2 = nv.models.multiBarChart()
       .transitionDuration(0)
       .reduceXTicks(false)   //If 'false', every single x-axis tick label will be rendered.
       .rotateLabels(0)      //Angle to rotate x-axis labels.
       .showControls(false)   //Allow user to switch between 'Grouped' and 'Stacked' mode.
       .groupSpacing(0.3); //Distance between each group of bars.

    chart_mos2.xAxis
        .tickFormat(d3.format(",f"));

    chart_mos2.yAxis
        .tickFormat(d3.format(",.1f"));


    chart_mos2.forceY([d.moisture_min, d.moisture_max]);
    d3.select("#chart3 svg")
        .datum(mos_graphvar)
        .call(chart_mos2);


    //oxygen graph variable
    var o2_graph = [];

    for (i = 0; i < 10; i++) {
        o2_graph.push({ x: i, y: currentTruck.o2[i] });
    }

    var o2_graphvar = [
        {
            values: o2_graph,
            key: "O2",
            color: graphcolor
        }
    ];

    var chart_o2 = nv.models.multiBarChart()
        .transitionDuration(0)
        .reduceXTicks(false)   //If 'false', every single x-axis tick label will be rendered.
        .rotateLabels(0)      //Angle to rotate x-axis labels.
        .showControls(false)   //Allow user to switch between 'Grouped' and 'Stacked' mode.
        .groupSpacing(0.3); //Distance between each group of bars.

    chart_o2.xAxis
        .tickFormat(d3.format(',f'));

    chart_o2.yAxis
        .tickFormat(d3.format(',.1f'));

    //chart_o2.forceY([d.oxygen_min, d.oxygen_max]);
    d3.select('#chart2 svg')
        .datum(o2_graphvar)
        .call(chart_o2);

}

function detailsInfo(d) {
    var headingwidth = 'col-md-5';
    var datagwidth = 'col-md-7';
    var html =
        '<div class="panel panel-primary"><div class="panel-heading">Truck Info</div>'
            + '<div class="panel-body"><div class="row"><div class="' + headingwidth + '"><b>Truck Id.</b></div><div class="' + datagwidth + '">: ' + currentTruck.Trucknumber + '</div></div>'
            + '<div class="row"><div class="' + headingwidth + '"><b>Driver Name</b></div><div class="' + datagwidth + '">: ' + currentTruck.Drivername + '</div></div></div></div>'
            + '<div class="panel panel-success"><div class="panel-heading">Current Location</div>'
            + '<div class="panel-body mylocationdiv"><div class="row"><div class="' + headingwidth + '"><b>Latitude</b></div><div class="' + datagwidth + '">: ' + d.Latitude + '</div></div>'
            + '<div class="row"><div class="' + headingwidth + '"><b>Longitude</b></div><div class="' + datagwidth + '">: ' + d.Longitude + '</div></div>'
            //+ '<div class="row"><div class="' + headingwidth + '"><b>Location</b></div><div class="' + datagwidth + '">: ' + d.Address + '</div></div>'
            + '</div></div>'
            + '<div class="panel panel-info"><div class="panel-heading">Average Sensor Reading</div>'
            + '<div class="panel-body">'
            + '<div class="row"><div class="' + headingwidth + '"><b>Co2</b></div><div class="' + datagwidth + '">: ' + d.Co2+ '</div></div>'
            + '<div class="row"><div class="' + headingwidth + '"><b>Moisture</b></div><div class="' + datagwidth + '">: ' + d.Moisture+ '</div></div>'
            + '<div class="row"><div class="' + headingwidth + '"><b>Temperature</b></div><div class="' + datagwidth + '">: ' + d.Oxygen + '</div></div>'
            + '<div class="row"><div class="' + headingwidth + '"><b>Ethylene</b></div><div class="' + datagwidth + '">: ' + d.Ethylene + '</div></div>'
            + '<div class="row"><div class="' + headingwidth + '"><b>Pressure</b></div><div class="' + datagwidth + '">: ' + d.Pressure + '</div></div>'
            + '<div class="row"><div class="' + headingwidth + '"><b>Temperature</b></div><div class="' + datagwidth + '">: ' + d.Temperature + '</div></div>'
            + '</div></div>';
           
    return html;
}

function togglemap(e, truckId) {
    $('#truck').val(truckId);
    e.preventDefault();
}

function createDirectionsManager() {
    if (!directionsManager) {
        directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
    }
    directionsManager.resetDirections();
}

function addWaypoint() {
    if (!directionsManager) { createDirectionsManager(); }
    
    var locstart = new Microsoft.Maps.Location(currentTruck.StartLat, currentTruck.StartLong);
    var locend = new Microsoft.Maps.Location(currentTruck.EndLat, currentTruck.EndLong);
    directionsManager.resetDirections();
    if (directionsManager.getAllWaypoints().length < 2) {
        directionsManager.resetDirections();
        var startWaypoint = new Microsoft.Maps.Directions.Waypoint({ address: 'Seattle, WA', location: locend });
        directionsManager.addWaypoint(startWaypoint);
        var endWaypoint = new Microsoft.Maps.Directions.Waypoint({ address: 'Tacoma, WA', location: locstart });
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
    } else {
        addWaypoint();
    }
}

