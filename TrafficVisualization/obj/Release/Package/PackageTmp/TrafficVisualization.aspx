<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrafficVisualization.aspx.cs"
    Inherits="TrafficVisualization.TrafficVisualization" %>

<!DOCTYPE html>

<html style="height: 95%">
<head runat="server">
    <title>Traffic Visualization</title>

    <script type="text/javascript" src="/assets/jquery-1.11.1.js"></script>
    <script charset="UTF-8" type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"></script>

    <link href="/assets/nvd3/src/nv.d3.css" rel="stylesheet" type="text/css">
    <script src="/assets/nvd3/lib/d3.v3.js"></script>
    <script src="/assets/nvd3/nv.d3.js"></script>
    <script src="/assets/nvd3/src/tooltip.js"></script>
    <script src="/assets/nvd3/src/utils.js"></script>
    <script src="/assets/nvd3/src/models/legend.js"></script>
    <script src="/assets/nvd3/src/models/axis.js"></script>
    <script src="/assets/nvd3/src/models/multiBar.js"></script>
    <script src="/assets/nvd3/src/models/multiBarChart.js"></script>


    <style type="text/css">
        body {
            font-family: Calibri, Candara, Segoe, "Segoe UI", Optima, Arial, sans-serif;
        }

        a {
            text-decoration: inherit;
            color: black;
            font-size: 20px;
        }

        .hidden {
            display: none;
        }

        .tab {
            position: absolute;
            top: 1%;
            left: 26%;
            width: 45%;
            height: 69%;
        }

        .detail {
            width: 95%;
            min-height: 100%;
            height: 100%;
            margin: auto;
        }

        .location_div {
            margin-top: 3%;
            background-color: #00B050;
        }

        .truckinfo_div {
            margin-top: 3%;
            background-color: #92D050;
        }

        .currentsesor_div {
            margin-top: 3%;
            background-color: #0070C0;
        }

        h3, p, h4 {
            line-height: 0em;
        }

        ul {
            list-style-type: none;
        }
    </style>


</head>
<body style="background-color: #00B0F0; width: 98%; height: 100%">

    <div style="width: 25%; min-height: 72%; height: 70%; padding-top: 0px; margin-left: .2%; display: inline-block; vertical-align: top">
        <div id='truck1_det' class='detail'></div>
        <div id='truck2_det' class='detail hidden'></div>
        <div id='truck3_det' class='detail hidden'></div>
        <div id='truck4_det' class='detail hidden'></div>
    </div>

    <div style="width: 45%; min-height: 70%; display: inline-block">
        <div id='truck1' class='tab'></div>
        <div id='truck2' class='tab hidden'></div>
        <div id='truck3' class='tab hidden'></div>
        <div id='truck4' class='tab hidden'></div>
    </div>

    <div class="PREDICTIONS" style="width: 25%; min-height: 72%; height: 70%; margin-left: 2%; display: inline-block; vertical-align: top; text-align: center; background-color: #5B9BD5">
        Machine Learning based Predictions
	<center><div id = "scorelabel1" class="scorelabel1" style="width:100px;height:100px;border:1px solid #000;background-color: #00FF00"><p>truck 1</p></div></center>
        <div id="scorelabel1_content" class="scorelabel1_content">
            <p></p>
        </div>

        <center><div id = "scorelabel2" class="scorelabel2" style="width:100px;height:100px;border:1px solid #000;background-color: #00FF00"><p>truck 2</p></div></center>
        <div id="scorelabel2_content" class="scorelabel2_content">
            <p></p>
        </div>

        <center><div id = "scorelabel3" class="scorelabel3" style="width:100px;height:100px;border:1px solid #000;background-color: #00FF00"><p>truck 3</p></div></center>
        <div id="scorelabel3_content" class="scorelabel3_content">
            <p></p>
        </div>

        <center><div id = "scorelabel4" class="scorelabel4" style="width:100px;height:100px;border:1px solid #000;background-color: #00FF00"><p>truck 4</p></div></center>
        <div id="scorelabel4_content" class="scorelabel4_content">
            <p></p>
        </div>

    </div>

    <div id="chart1" class="chart1" style="background-color: #5B9BD5">
        <svg></svg>
    </div>
    <div id='chart2' class="chart2" style="background-color: #5B9BD5">
        <svg></svg>
    </div>
    <div id='chart3' class="chart3" style="background-color: #5B9BD5">
        <svg></svg>
    </div>
    <div id='chart4' class="chart4" style="background-color: #5B9BD5">
        <svg></svg>
    </div>
    <div id='chart5' class="chart5" style="background-color: #5B9BD5">
        <svg></svg>
    </div>
    <div id='chart6' class="chart6" style="background-color: #5B9BD5">
        <svg></svg>
    </div>

    <div style="position: absolute; width: 60%; top: 95%; left: 1%">
        <a href="" id="truck1_link" onclick="(function(e, id){app.togglemap(e, id); })(event, 1)">Truck 1</a>&nbsp;|&nbsp;
		<a href="" onclick="(function(e, id){app.togglemap(e, id); })(event, 2)">Truck 2</a>&nbsp;|&nbsp;
		<a href="" onclick="(function(e, id){app.togglemap(e, id); })(event, 3)">Truck 3</a>&nbsp;|&nbsp;
		<a href="" onclick="(function(e, id){app.togglemap(e, id); })(event, 4)">Truck 4</a>
    </div>

    <script type="text/javascript">
        $(function () {
            //

            $.ajaxSetup({ cache: false });
            app = {};
            app.trucks = {};
            app.maps = {};
            cnt = 0;
            app.poll = function () {
                cnt = cnt + 1;

                $.ajax({
                    url: "/api/Realtimedashboard?query=test",
                    data: { "counter": cnt }
                }).done(function (data) {
                    //app.table.clear();					
                    $.each(data, function (index, d) {
                        alert(d.truck_id);
                        alert(d.driver_name);

                        ShowTruckDetails(d);
                        $('#truck' + d.truck_id + '_det').html(app.detailsInfo(d));

                        ////$('#truck'+d.truck_id+'_pred').html(app.pred(d));

                        //var loc = new Microsoft.Maps.Location(d.latitude, d.longitude);
                        //app.maps[d.truck_id].setView({ center: loc });

                        /* debugger;
						var path = [];
						currentAnimation = new Bing.Maps.Animations.PathAnimation(path, function (coord) {
							pin.setLocation(coord);
						}, true, 40000);						
						currentAnimation.play(); */

                       // app.trucks[d.truck_id].setLocation(loc);
                        ////app.table.row.add([d.driver_name, d.route_name, d.truck_id, d.timestamp.split(' ')[1], d.longitude.substring(0,7), d.latitude.substring(0,7)]).draw();
                    });
                });
            };

            function ShowTruckDetails(d) {
                var html =
                   '<div class="truckinfo_div row"><div class="col-md-4"><img class="thumbnail" src="Images/icons/truck_info.png" /></div><div class="col-md-8"><h4>Truck Info.</h4><span>Truck Id :' + d.truck_id + '</span><br><span> Timestamp: ' + d.timestamp.split(' ')[1] + '</span></div></div>'
                   + '<div class="location_div row" ><div class="col-md-4"><img class="thumbnail" src="Images/icons/location.png" /></div><div class="col-md-8"><h4>Current Location</h4><span>Latitude :' + d.latitude.substring(0, 7) + '</span><br><span>Longitude : ' + d.longitude.substring(0, 7) + '</span></div></div>'
                   + '<div class="currentsesor_div row" ><div class="col-md-4"><img class="thumbnail " src="Images/icons/current_sesnsor.png" /></div><div class="col-md-8"><h4><span>Current Sensor Reading</h4><span>Temperature :' + d.latitude.substring(0, 7) + '</span><br><span>Co2 : ' + d.longitude.substring(0, 7) + '</span></div></div>';
                return html;
            }

            app.init = function () {
                //initializing data table

                //app.table = $('#table').DataTable();

                //initializing map
                initmap(-117.853500, 34.068298, 1, 'truck1', 11);
                initmap(-78.07014936456798, 40.78080528668958, 2, 'truck2', 9);
                initmap(-75.03578280898331, 40.6519404102645, 3, 'truck3', 10);
                initmap(-118.119797, 34.585232, 4, 'truck4', 12);

                app.poll();
                app.intervalId = setInterval(function () {
                    app.poll();
                }, 5000);
            };
            var truckno;

            app.togglemap = function (e, truck_id) {
                truckno = truck_id;

                //alert(truck_id);
                if (truck_id == 1) {			// To disable: 
                    $('.scorelabel1').show();
                    $('.scorelabel2').css("display", "none");
                    $('.scorelabel3').css("display", "none");
                    $('.scorelabel4').css("display", "none");

                    $('.scorelabel1_content').show();

                    $('.scorelabel2_content').css("display", "none");
                    $('.scorelabel3_content').css("display", "none");
                    $('.scorelabel4_content').css("display", "none");


                }
                else if (truck_id == 2) {
                    //	$('.chart1').replaceWith( "<div id='chart1' class='chart1' style='width: 15%; min-height:25%;  margin-left:1%;margin-top:1%; vertical-align: top; display: inline-block;background-color: #5B9BD5'><svg></svg></div>" );						
                    $('.scorelabel2').show();
                    $('.scorelabel1').css("display", "none");
                    $('.scorelabel3').css("display", "none");
                    $('.scorelabel4').css("display", "none");

                    $('.scorelabel2_content').show();
                    $('.scorelabel1_content').css("display", "none");
                    $('.scorelabel3_content').css("display", "none");
                    $('.scorelabel4_content').css("display", "none");
                }
                else if (truck_id == 3) {
                    $('.scorelabel3').show();
                    $('.scorelabel1').css("display", "none");
                    $('.scorelabel2').css("display", "none");
                    $('.scorelabel4').css("display", "none");

                    $('.scorelabel3_content').show();
                    $('.scorelabel1_content').css("display", "none");
                    $('.scorelabel2_content').css("display", "none");
                    $('.scorelabel4_content').css("display", "none");
                }
                else if (truck_id == 4) {
                    $('.scorelabel4').show();
                    $('.scorelabel1').css("display", "none");
                    $('.scorelabel2').css("display", "none");
                    $('.scorelabel3').css("display", "none");

                    $('.scorelabel4_content').show();
                    $('.scorelabel1_content').css("display", "none");
                    $('.scorelabel2_content').css("display", "none");
                    $('.scorelabel3_content').css("display", "none");
                }
                else {
                    /* $('.scorelabel1').css("display", "none");
                    $('.scorelabel2').css("display", "none");
                    $('.scorelabel3').css("display", "none");
                    $('.scorelabel4').css("display", "none");
                    
                    
                    $('.scorelabel1_content').css("display", "none");
                    $('.scorelabel2_content').css("display", "none");
                    $('.scorelabel3_content').css("display", "none");
                    $('.scorelabel4_content').css("display", "none"); */
                }
                //debugger;
                e.preventDefault();
                $('.tab').hide();
                $('.detail').hide();
                $('#truck' + truck_id).show();
                $('#truck' + truck_id + '_det').show();
                //$('#truck'+truck_id+'_pred').show();
                $(e.target).siblings().css({ 'text-decoration': 'inherit' });
                $(e.target).css({ 'text-decoration': 'underline' });
            }
            //var co2list=[];
            var graphcolor;
            app.detailsInfo = function (d) {
                if (truckno == 1 && d.truck_id == 1) {

                    co2GrpahData(d.co2List);
                    o2GrpahData(d.tempList);
                    //alert(d.pressureList);
                    mosGrpahData(d.moistureList);
                    ethyleneGrpahData(d.ethyleneList);
                    pressureGrpahData(d.moistureList);
                    tempGraphData(d.tempList);

                }
                else if (truckno == 2 && d.truck_id == 2) {
                    co2GrpahData(d.co2List);
                    o2GrpahData(d.tempList);
                    mosGrpahData(d.moistureList);
                    ethyleneGrpahData(d.ethyleneList);
                    pressureGrpahData(d.pressureList);
                    tempGraphData(d.tempList);
                }
                else if (truckno == 3 && d.truck_id == 3) {
                    co2GrpahData(d.co2List);
                    o2GrpahData(d.tempList);
                    mosGrpahData(d.moistureList);
                    ethyleneGrpahData(d.ethyleneList);
                    pressureGrpahData(d.pressureList);
                    tempGraphData(d.tempList);
                }
                else if (truckno == 4 && d.truck_id == 4) {
                    co2GrpahData(d.co2List);
                    o2GrpahData(d.tempList);
                    mosGrpahData(d.moistureList);
                    ethyleneGrpahData(d.ethyleneList);
                    pressureGrpahData(d.pressureList);
                    tempGraphData(d.tempList);
                }
                if (d.truck_id == 1) {

                    if (d.scoreLabel == 0) {
                        $('.scorelabel1').replaceWith("<div id = 'scorelabel1' class='scorelabel1 hidden' style='width:100px;height:100px;border:1px solid #000;background-color: #00FF00'><p>truck 1</p></div>");
                        //$('.scorelabel1_content').replaceWith( "<div id='scorelabel1_content' class='scorelabel1_content hidden'><ul><li>scoreLabel : "+d.scoreLabel+"</li><li>co2 : "+d.co2+"</li><li>moisture : "+d.moisture+"</li><li>oxygen : "+d.oxygen+"</li><li>ethylene : "+d.ethylene+"</li><li>pressure : "+d.pressure+"</li></ul></div>" );									
                    }
                    else if (d.scoreLabel == 1) {
                        $('.scorelabel1').replaceWith("<div id = 'scorelabel1' class='scorelabel1 hidden' style='width:100px;height:100px;border:1px solid #000;background-color: #FF0000'><p>truck 1</p></div>");
                    }
                    $('.scorelabel1_content').replaceWith("<div id='scorelabel1_content' class='scorelabel1_content hidden'><ul><li><pre>Score Label : " + d.scoreLabel + "</pre></li><li><pre>        Co2 : " + d.co2 + "</pre></li><li><pre>   Moisture : " + d.moisture + "</pre></li><li><pre>     Oxygen : " + d.oxygen + "</pre></li><li><pre>   Ethylene : " + d.ethylene + "</pre></li><li><pre>   Pressure : " + d.pressure + "</pre></li><li><pre>Temperature : " + d.temp + "</pre></li></ul></div>");

                }
                else if (d.truck_id == 2) {

                    if (d.scoreLabel == 0) {
                        $('.scorelabel2').replaceWith("<div id = 'scorelabel2' class='scorelabel2 hidden' style='width:100px;height:100px;border:1px solid #000;background-color: #00FF00'><p>truck 2</p></div>");
                        //$('.scorelabel2_content').replaceWith( "<div id='scorelabel2_content' class='scorelabel2_content hidden'><ul><li>scoreLabel : "+d.scoreLabel+"</li><li>co2 : "+d.co2+"</li><li>moisture : "+d.moisture+"</li><li>oxygen : "+d.oxygen+"</li><li>ethylene : "+d.ethylene+"</li><li>pressure : "+d.pressure+"</li></ul></div>" );									
                    }
                    else if (d.scoreLabel == 1) {
                        $('.scorelabel2').replaceWith("<div id = 'scorelabel2' class='scorelabel2 hidden' style='width:100px;height:100px;border:1px solid #000;background-color: #FF0000'><p>truck 2</p></div>");
                    }
                    $('.scorelabel2_content').replaceWith("<div id='scorelabel2_content' class='scorelabel2_content hidden'><ul><li><pre>Score Label : " + d.scoreLabel + "</pre></li><li><pre>        Co2 : " + d.co2 + "</pre></li><li><pre>   Moisture : " + d.moisture + "</pre></li><li><pre>     Oxygen : " + d.oxygen + "</pre></li><li><pre>   Ethylene : " + d.ethylene + "</pre></li><li><pre>   Pressure : " + d.pressure + "</pre></li><li><pre>Temperature : " + d.temp + "</pre></li></ul></div>");

                }
                else if (d.truck_id == 3) {
                    if (d.scoreLabel == 0) {
                        $('.scorelabel3').replaceWith("<div id = 'scorelabel3' class='scorelabel3 hidden' style='width:100px;height:100px;border:1px solid #000;background-color: #00FF00'><p>truck 3</p></div>");
                        //$('.scorelabel3_content').replaceWith( "<div id='scorelabel3_content' class='scorelabel3_content hidden'><ul><li>scoreLabel : "+d.scoreLabel+"</li><li>co2 : "+d.co2+"</li><li>moisture : "+d.moisture+"</li><li>oxygen : "+d.oxygen+"</li><li>ethylene : "+d.ethylene+"</li><li>pressure : "+d.pressure+"</li></ul></div>" );									
                    }
                    else if (d.scoreLabel == 1) {
                        $('.scorelabel3').replaceWith("<div id = 'scorelabel3' class='scorelabel3 hidden' style='width:100px;height:100px;border:1px solid #000;background-color: #FF0000'><p>truck 3</p></div>");
                    }
                    $('.scorelabel3_content').replaceWith("<div id='scorelabel3_content' class='scorelabel3_content hidden'><ul><li><pre>Score Label : " + d.scoreLabel + "</pre></li><li><pre>        Co2 : " + d.co2 + "</pre></li><li><pre>   Moisture : " + d.moisture + "</pre></li><li><pre>     Oxygen : " + d.oxygen + "</pre></li><li><pre>   Ethylene : " + d.ethylene + "</pre></li><li><pre>   Pressure : " + d.pressure + "</pre></li><li><pre>Temperature : " + d.temp + "</pre></li></ul></div>");

                }
                else if (d.truck_id == 4) {
                    if (d.scoreLabel == 0) {
                        $('.scorelabel4').replaceWith("<div id = 'scorelabel4' class='scorelabel4 hidden' style='width:100px;height:100px;border:1px solid #000;background-color: #00FF00'><p>truck 4</p></div>");
                        //$('.scorelabel4_content').replaceWith( "<div id='scorelabel4_content' class='scorelabel4_content hidden'><ul><li>scoreLabel : "+d.scoreLabel+"</li><li>co2 : "+d.co2+"</li><li>moisture : "+d.moisture+"</li><li>oxygen : "+d.oxygen+"</li><li>ethylene : "+d.ethylene+"</li><li>pressure : "+d.pressure+"</li></ul></div>" );									
                    }
                    else if (d.scoreLabel == 1) {
                        $('.scorelabel4').replaceWith("<div id = 'scorelabel4' class='scorelabel4 hidden' style='width:100px;height:100px;border:1px solid #000;background-color: #FF0000'><p>truck 4</p></div>");
                    }
                    $('.scorelabel4_content').replaceWith("<div id='scorelabel4_content' class='scorelabel4_content hidden'><ul><li><pre>Score Label : " + d.scoreLabel + "</pre></li><li><pre>        Co2 : " + d.co2 + "</pre></li><li><pre>   Moisture : " + d.moisture + "</pre></li><li><pre>     Oxygen : " + d.oxygen + "</pre></li><li><pre>   Ethylene : " + d.ethylene + "</pre></li><li><pre>   Pressure : " + d.pressure + "</pre></li><li><pre>Temperature : " + d.temp + "</pre></li></ul></div>");

                    //$('.scorelabel').attr('style', 'background-color: blue');
                }
                //add d3 graphs

                if (truckno == 2) {
                    //alert("hi");
                    graphcolor = '#ff7f0e';
                    //$('.chart1').replaceWith( "<div id='chart1' class='chart1' style='width: 15%; min-height:25%;  margin-left:1%;margin-top:1%; vertical-align: top; display: inline-block;background-color: #5B9BD5'><svg></svg></div>" );						
                    //nv.addGraph(graph());
                    $('.scorelabel2_content').show();
                    $('.scorelabel2').show();
                }
                else if (truckno == 1) {
                    graphcolor = '#00FFFF';
                    //nv.addGraph(graph());					
                    $('.scorelabel1_content').show();
                    $('.scorelabel1').show();
                }
                else if (truckno == 3) {
                    graphcolor = '#FF33CC';
                    //nv.addGraph(graph());				
                    $('.scorelabel3_content').show();
                    $('.scorelabel3').show();
                }
                else if (truckno == 4) {
                    graphcolor = '#FF0000';
                    //			
                    $('.scorelabel4_content').show();
                    $('.scorelabel4').show();
                }

                nv.addGraph(graph());

                var html = '<div style="width: 100%;height: 24%" class="truckinfo_div" ><div style="position: relative; top:5%; left:2%;height: 90%"><div style="height: 100%;margin-left:4%; vertical-align: top;display:inline-block;"><h3>TRUCK INFO</h3><pre><span style="padding-left:20px">Truck Id : </span><span>' + d.truck_id + '</span><br><span style="padding-left:20px">  Driver : ' + d.driver_name + '</span></pre></div></div></div>'
				+ '<div style="width: 100%;" class="location_div" ><div style="position: relative; top:5%; left:2%;height: 90%"><div style="height: 100%;margin-left:4%; vertical-align: top;display:inline-block;"><h4>CURRENT LOCATION</h4><pre><span> Latitude :</span><span> ' + d.latitude.substring(0, 7) + '</span><br><span>Longitude : ' + d.longitude.substring(0, 7) + '</span><br><span> Location : ' + d.location.split(',')[0] + ',' + '</span><br><span>' + d.location.split(',')[1] + ',' + d.location.split(',')[2] + '</span></pre></div></div></div>'
				+ '<div style="width: 100%;" class="currentsesor_div" ><div ><div style="margin-left:4%; vertical-align: top;display:inline-block;"><h4>CURRENT SENSOR READING</h4><pre><span>Temperature : </span><span> ' + d.temp + '</span><br><span>        Co2 : ' + d.co2 + '</span><br/><span>    Moisture :</span><span> ' + d.moisture + '</span><br><span>         O2 : ' + d.oxygen + '</span><br/><span>  Ethylene :</span><span> ' + d.ethylene + '</span><br><span>  Pressure : ' + d.pressure + '</span></pre><br></div></div></div>';
                /* +'<div style="width: 100%;height: 22%" class="location_div"><img style="height: 80%" src="assets/icons/location.png" /><div style="display: inline-block;vertical-align: top"> <h3>CURRENT LOCATION</h3><p><span>Latitude</span><span>'+d.latitude.substring(0,7)+'</span></p><p><span>Longitude</span><span>'+d.longitude.substring(0,7)+'</span></p></div></div>'+ 
				'<div style="width: 100%;height: 22%;line-height: 1em;" class="currentsesor_div"><img style="height: 80%" src="assets/icons/current_sesnsor.png" /><div style="display: inline-block;vertical-align: top"> <h3>CURRENT SENSOR READING</h3><span>Temperature</span><span>'+d.latitude.substring(0,7)+'</span></p><p><span>Co2</span><span>'+d.longitude.substring(0,7)+'</span></p></div></div>';
				 */
                return html;
            }


            //45.5, -122.5
            function initmap(c_long, c_lat, truckid, div_id, zoom_level) {
                var map_options = {
                    credentials: "Ap-y7iQWyP7PrWGIEENR3mOY8bQKwBi_9cc7rzAkPku1a6_1f6HMLleBQZoz5mXa",
                    center: new Microsoft.Maps.Location(c_lat, c_long),
                    showDashboard: false,
                    enableSearchLogo: false,
                    mapTypeId: Microsoft.Maps.MapTypeId.road,
                    zoom: zoom_level
                }
                var map = app.maps[truckid] = new Microsoft.Maps.Map(document.getElementById(div_id), map_options);
                //var loc = new Microsoft.Maps.Location(lat, lon);
                app.trucks[truckid] = new Microsoft.Maps.Pushpin(map.getCenter(), { icon: 'assets/icons/truck_black_' + truckid + '.png' });
                map.entities.push(app.trucks[truckid]);

            }

            //Each bar represents a single discrete quantity.

            var temp_graphvar;
            function tempGraphData(temp) {
                var temp_graph = [];

                for (var i = 0; i < temp.length; i++) {
                    temp_graph.push({ x: i, y: temp[i] });
                }

                temp_graphvar = [
                   {
                       values: temp_graph,
                       key: 'TEMPERATURE',
                       color: graphcolor
                   }
                ];
            }

            var co2_graphvar;
            function co2GrpahData(co) {

                //alert(co);
                var co2_graph = [];

                /* for (var i = 0; i < 100; i++) {
                  sin.push({x: i, y: Math.sin(i/10)}); */

                for (var i = 0; i < co.length; i++) {
                    co2_graph.push({ x: i, y: co[i] });
                }

                co2_graphvar = [
                   {
                       values: co2_graph,
                       key: 'CO2',
                       color: graphcolor
                   }
                ];
            }

            //oxygen graph variable
            var o2_graphvar;
            function o2GrpahData(o) {
                var o2_graph = [];
                for (var i = 0; i < o.length; i++) {
                    o2_graph.push({ x: i, y: o[i] });
                }

                o2_graphvar = [
                   {
                       values: o2_graph,
                       key: 'O2',
                       color: graphcolor
                   }
                ];
            }

            //moisture grapg variable
            var mos_graphvar;
            function mosGrpahData(mos) {
                var moisture_graph = [];

                for (var i = 0; i < mos.length; i++) {
                    moisture_graph.push({ x: i, y: mos[i] });
                }

                mos_graphvar = [
                   {
                       values: moisture_graph,
                       key: 'MOISTURE',
                       color: graphcolor
                   }
                ];
            }

            //ethylene graph variable 
            var ethylene_graphvar;
            function ethyleneGrpahData(eth) {
                var ethylene_graph = [];
                for (var i = 0; i < eth.length; i++) {
                    ethylene_graph.push({ x: i, y: eth[i] });
                }
                ethylene_graphvar = [
                {
                    values: ethylene_graph,
                    key: 'ETHYLENE',
                    color: graphcolor
                }
                ];
            }
            //pressure graph variable

            var pressure_graphvar;
            function pressureGrpahData(pre) {

                var pressure_graph = [];

                for (var i = 0; i < pre.length; i++) {
                    pressure_graph.push({ x: i, y: pre[i] });
                }
                pressure_graphvar = [
                {
                    values: pressure_graph,
                    key: 'PRESSURE',
                    color: graphcolor
                }
                ];
            }


            function graph() {
                var chart = nv.models.lineChart()

	                 .margin({ left: 10 })  //Adjust chart margins to give the x-axis some breathing room.
	                .useInteractiveGuideline(false)  //We want nice looking tooltips and a guideline!
	                .transitionDuration(350)  //how fast do you want the lines to transition?
	                .showLegend(true)       //Show the legend, allowing users to turn on/off line series.
	                .showYAxis(true)        //Show the y-axis
	                .showXAxis(false)        //Show the x-axis
                //   .height(50)
                ;

                //  chart.yAxis.tickFormat(d3.format(',.1f'));

                d3.select('#chart1 svg')
				    .datum(co2_graphvar)
				    .call(chart);


                d3.select('#chart2 svg')
                  .datum(o2_graphvar)
                  .call(chart);

                d3.select('#chart3 svg')
                   .datum(mos_graphvar)
                   .call(chart);

                d3.select('#chart4 svg')
			    	.datum(ethylene_graphvar)
			   		.call(chart);

                d3.select('#chart5 svg')
			    	.datum(pressure_graphvar)
			   		.call(chart);

                d3.select('#chart6 svg')
			    	.datum(temp_graphvar)
			   		.call(chart);

                nv.utils.windowResize(chart.update);

                return chart;
            }
            app.init();
            $("#truck1_link").trigger("click");

        });
    </script>


    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
