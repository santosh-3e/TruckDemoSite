<%@ Page Title="Eyera - Fleet Analytics Demo" Language="C#" MasterPageFile="~/Default.Master"
    AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TrafficVisualization.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="text" id="truck" value="1" class="hidden" />
    <div class="row">
        <div class="col-md-6">
            <h2 style="margin-top: 5px; height: 50px">
                <a href="http://thirdeyecss.com/eyera" style="color: black; text-decoration: none">
                    <img src="Images/eyera-small.png" style="width: 200px; height: auto; margin-bottom: 13px" />
                    -&nbsp;&nbsp;&nbsp;Fleet Analytics Demo
                </a>
            </h2>
            <p style="font-size:20px; padding-left:15px">Solutions for Internet of things</p>
        </div>

        <div class="col-md-6" style="margin-top: 15px">
            <div class="btn-group btn-group-sm pull-right" style="margin-top: 5px">
                <div id="mystartbtn" style="display:inline-block">

                    <input type="checkbox" class="btn" id="resetDashboard"
                        eventfor="2" btn="toggleBtn"
                        data-on-text="STOP"
                        data-off-text="START"
                        data-size="small"
                        data-off-color="info"
                        data-handle-width="30px"
                        name="start-datafeed" />
                </div>
                 <div id="adversebutton" style="display:inline-block">

                <input type="checkbox" class="btn" id="btnChangeData" 
                    eventfor="1" 
                    btn="toggleBtn"
                    data-on-text="+Ve Prediction"
                    data-off-text="Adverse Condition"
                    data-size="small"
                    data-off-color="warning"
                    data-on-color="success"
                    data-handle-width="100px"
                    name="start-datafeed" />    

                 </div>
            </div>
                      
             <ul class="nav nav-pills" id="aboutus">
                <li role="presentation">
                    <a href="http://thirdeyecss.com/about-us/" style="color: black">
                        <img src="Images/TElogo.png" style="height:50px" />&nbsp; <b>Talk to Third Eye</b></a>
                </li>

                  <li role="presentation">
                    <a href="http://thirdeyecss.com/about-us/" style="color: black; padding-top:25px; padding-bottom:25px"><b>Technology</b></a>
                </li>
            </ul>
        </div>
    </div>

    <div id="DemoDiv" style="display:none">
          <div class="row">
        <ul class="nav nav-tabs" role="tablist" id="truckmenu">
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
    </div>
    <div class="lead"></div>
    <div class="row">
        <div class="col-md-3">
            <div class="row">
                <div id='truck_det' class='detail col-md-12'></div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="row">
                <div class='tab col-md-12'>
                    <div id='truck_map'  
                        style="position:absolute; width:95%; height:478px;"
                        >
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="row">
                <div class="col-md-12">
                    <div id="score_prediction" style="height:478px; border: solid 1px red">
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="row">
        <div class="lead"></div>
    </div>
    <div class="row">
        <div class="col-md-2">
            <div id="chart1" class="chart chart1">
                <svg></svg>
            </div>
        </div>
        <div class="col-md-2">
            <div id='chart2' class="chart chart2">
                <svg></svg>
            </div>
        </div>
        <div class="col-md-2">
            <div id='chart3' class="chart chart3">
                <svg></svg>
            </div>
        </div>
        <div class="col-md-2">
            <div id='chart4' class="chart chart4">
                <svg></svg>
            </div>
        </div>
        <div class="col-md-2">
            <div id='chart5' class="chart chart5">
                <svg></svg>
            </div>
        </div>
        <div class="col-md-2">
            <div id='chart6' class="chart chart6">
                <svg></svg>
            </div>
        </div>
    </div>
    </div>
   
     <div id="StartDiv" style="text-align:center; padding-top:100px; display:none">
        <a href="" id="cmdSTartDemo"><img src="Images/Play.png" /></a>
        <h1 style="font-weight:bold">Start Fleet Analytics Demo</h1>
    </div>
  

    <nav class="navbar navbar-default navbar-fixed-bottom">
  <div class="container-fluid">
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav pull-right">
        <li><a href="http://thirdeyecss.com/">Third Eye Consulting Services & Solutions LLC.</a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
    <script src="/Scripts/realtimedashboard.js"></script>
  </asp:Content>
