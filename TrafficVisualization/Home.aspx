<%@ Page Title="Eyera - Fleet Analytics Demo" Language="C#" MasterPageFile="~/Default.Master"
    AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TrafficVisualization.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="text" id="truck" value="1" class="hidden" />
    <div class="row">
        <div class="col-md-4">
            <h2 style="margin-top: 5px; height: 50px"> 
                <a href="http://thirdeyecss.com/eyera" style="color: black; text-decoration: none">
                    <img src="Images/eyera-small.png" style="width: 211px; height: auto; margin-bottom: 13px" />
                </a>
            </h2>
            <p style="font-size:12px; padding-left:15px; color:#1C3052">Solutions for the Internet of Things</p>
        </div>

        <div class="col-md-4">
            <p style="font-size: 30px; color:#406CB4 ;margin-top: 20px; text-align: center; font-weight: 700">Fleet Analytics Demo</p>
        </div>

        <div class="col-md-4" style="margin-top: 15px">
             <ul class="nav nav-pills pull-right" id="aboutus">
                <li role="presentation">
                    <a href="http://thirdeyecss.com/about-us/" style="color: black">
                        <img src="Images/TElogo.png" style="height:50px;font-size:15px; padding-right:5px"/>Talk to Third Eye</a>
                </li>
            </ul>
        </div>
    </div>

    <div id="DemoDiv" style="display: none ;">
        <div class="row">
            <nav class="navbar navbar-default">
              
            <ul class="nav navbar-nav" role="tablist" id="truckmenu">
                <li class="active">
                    <a href="#truck1" id="truck1_link" role="tab" data-toggle="tab" onclick="(function(e, id){togglemap(e, id); })(event, 1)">Truck 1 - Sushi</a>
                </li>
                <li>
                    <a href="#truck2" role="tab" data-toggle="tab" onclick="(function(e, id){togglemap(e, id); })(event, 2)">Truck 2 - Vegetables</a>
                </li>
                <li>
                    <a href="#truck3" role="tab" data-toggle="tab" onclick="(function(e, id){togglemap(e, id); })(event, 3)">Truck 3 - Fruits</a>
                </li>
                <li>
                    <a href="#truck4" role="tab" data-toggle="tab" onclick="(function(e, id){togglemap(e, id); })(event, 4)">Truck 4 - Dried Fruits</a>
                </li>
            </ul>

            <ul class="nav navbar-nav navbar-right" role="tablist">
                <li>
                    <div id="mystartbtn" style="display: inline-block ; margin-right:10px">

                        <input type="checkbox" class="btn" id="resetDashboard"
                            eventfor="2" btn="toggleBtn"
                            data-on-text="Stop Demo"
                            data-off-text="Start Demo"
                            data-size="small"
                            data-off-color="info"
                            data-handle-width="70px"
                            name="start-datafeed" />
                    </div>
                </li>
                <li>
                    <div id="adversebutton" style="display: inline-block">

                        <input type="checkbox" class="btn" id="btnChangeData" eventfor="1"
                            btn="toggleBtn"
                            data-on-text="Send Data for Good Conditions"
                            data-off-text="Send Data for Adverse Conditions"
                            data-size="small"
                            data-off-color="warning"
                            data-on-color="success"
                            data-handle-width="190px"
                            name="start-datafeed" />
                    </div>
                    
                </li>
            </ul>
  </nav>
           <%-- <div class="btn-group btn-group-sm pull-right">

                <div id="mystartbtn" style="display: inline-block">
                    <ul class="nav nav-tabs" role="tablist" id="truckmenu1">
                        <li>
                            <input type="checkbox" class="btn" id="resetDashboard"
                        eventfor="2" btn="toggleBtn"
                        data-on-text="Stop Demo"
                        data-off-text="Start Demo"
                        data-size="small"
                        data-off-color="info"
                        data-handle-width="70px"
                        name="start-datafeed" />
                        </li>
                    </ul>

                </div>
            </div>--%>
        </div>

       
    <div class="row">
        <div class="col-md-3" style="margin-bottom:10px;">
            <div class="row">
                <div id='truck_det' class='detail col-md-12'></div>
            </div>
        </div>

        <div class="col-md-6" style="margin-bottom:10px">
            <div class="row">
                <div class='col-md-12'>
                    <div id='truck_map' style="position:absolute; width:95%; height:400px;"                        >
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3" style="margin-bottom:10px;">
            <div class="row">
                <div class="col-md-12">
                    <div id="score_prediction"; margin-bottom:"50px">
                    </div>
                </div>
            </div>
        </div>
       
         <%--<div class="col-md-3" style="margin-bottom:10px;">
            <div class="row">
                <div class="col-md-12">
                    <div id="Predective_Maintenance" style="height:478px;">
                    </div>
                </div>
            </div>
        </div>--%>
    </div>
  
    <div class="row">
        <div class="col-md-2">
            <div id="chart1" class="chart chart1"  style="border:1px;background-color:white; margin-top:20px">
                <svg></svg>
            </div>
        </div>
        <div class="col-md-2">
            <div id='chart2' class="chart chart2"  style="background-color:white; margin-top:20px">
                <svg></svg>
            </div>
        </div>
        <div class="col-md-2">
            <div id='chart3' class="chart chart3"  style="background-color:white; margin-top:20px">
                <svg></svg>
            </div>
        </div>
        <div class="col-md-2">
            <div id='chart4' class="chart chart4"  style="background-color:white; margin-top:20px">
                <svg></svg>
            </div>
        </div>
        <div class="col-md-2">
            <div id='chart5' class="chart chart5"  style="background-color:white; margin-top:31px">
                <svg></svg>
            </div>
        </div>
        <div class="col-md-2">
            <div id='chart6' class="chart chart6"  style="background-color:white ; margin-top:31px">
                <svg></svg>
            </div>
        </div>
    </div>
    </div>

    <div id="StartDiv" style="text-align:center; padding-top:20px; display:none;color:#1C3052 ">
         <div class="col-md-12">
             <p style="font-size: 17px; text-align: center; margin-top:70px ;font-weight: 600">This demo showcases the power of real time predictive analytics on Internet of Things data.</br>The business use case highlights the benefits of Predictive Maintenance for the trucking industry.</p>
         </div>
        <a href="" id="cmdSTartDemo"><img src="Images/start.PNG" /></a>
        <h1 style="font-weight:"bold">Start Fleet Analytics Demo</h1>
    </div>

    <nav class="navbar navbar-default navbar-fixed-bottom">
  <div class="container-fluid">
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav pull-right">
        <li><a href="http://thirdeyecss.com/">© 2016. All Rights Reserved. Third Eye Consulting Services & Solutions LLC.</a></li>
      </ul>

        <ul class="nav navbar-nav pull-left">
       <li><a href="http://thirdeyecss.com/tos-eyera-fleetanalytics">Terms of Services</a></li>
          <li><a href="http://thirdeyecss.com/contact-us/">Contact Third Eye</a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
    <script src="/Scripts/realtimedashboard.js"></script>
  </asp:Content>
