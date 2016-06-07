<%@ Page Title="Eyera - Fleet Analytics Demo" Language="C#" MasterPageFile="~/Default.Master"
    AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TrafficVisualization.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-md-8">
            <h2 style="margin-top:5px; height:60px">
                <a href="http://thirdeyecss.com/eyera" style="color: black; text-decoration:none">
                <img src="Images/eyera-small.png" style="width: 200px; height: auto; margin-bottom: 13px" />
                -&nbsp;&nbsp;&nbsp;Fleet Analytics Demo
                </a>

            </h2>

        </div>
        <div class="col-md-4" style="margin-top:15px">
            
            <div class="btn-group btn-group-sm pull-right" style="margin-top:5px">

                <input type="checkbox" class="btn" id="resetDashboard"
                    eventfor="2" btn="toggleBtn"
                    data-on-text="STOP"
                    data-off-text="START"
                    data-size="small"
                    data-off-color="info"
                    data-handle-width="30px"
                    name="start-datafeed" />
                <!--<input type="checkbox" class="btn" id="btnStartFeed" eventfor="0" btn="toggleBtn"
                data-on-text="Stop Data Feed"
                data-off-text="Start Data Feed"
                data-size="small"
                data-off-color="info"
                data-handle-width="100px"
                name="start-datafeed" />-->
                <input type="checkbox" class="btn" id="btnChangeData" eventfor="1" btn="toggleBtn"
                    data-on-text="+Ve Prediction"
                    data-off-text="-Ve Prediction"
                    data-size="small"
                    data-off-color="warning"
                    data-on-color="success"
                    data-handle-width="100px"
                    name="start-datafeed" />
            </div>
            
            <ul class="nav nav-pills"  id="aboutus">
                <li role="presentation" >
                    <a href="http://thirdeyecss.com/about-us/" style="color:black;font-size: 15px"><b>About Third Eye</b></a>
                </li>
               <%-- <li>
                    <a href="http://thirdeyecss.com/contact-us/" style="color: white; font-size: 15px">Contact</a>
                </li>--%>
            </ul>
            
        </div>
    </div>
    
    <input type="text" id="truck" value="1" class="hidden" />

    <div class="row">
        <ul class="nav nav-tabs" role="tablist">
            <li class="active">
                <a href="#truck1" id="truck1_link" role="tab" data-toggle="tab" onclick="(function(e, id){togglemap(e, id); })(event, 1)">Truck 1- Sushi</a>
            </li>
            <li>
                <a href="#truck2" role="tab" data-toggle="tab" onclick="(function(e, id){togglemap(e, id); })(event, 2)">Truck 2- Vegetables</a>
            </li>
            <li>
                <a href="#truck3" role="tab" data-toggle="tab" onclick="(function(e, id){togglemap(e, id); })(event, 3)">Truck 3- Fruits</a>
            </li>
            <li>
                <a href="#truck4" role="tab" data-toggle="tab" onclick="(function(e, id){togglemap(e, id); })(event, 4)">Truck 4- Dried Fruits</a>
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
                    <div id='truck_map'>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3" >
            <div class="row">
                <div class="col-md-12">
                   
                    <div id="score_prediction">
                        
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
    
    
<%--<div data-growl="container" class="alert" role="alert">
	<button type="button" class="close" data-growl="dismiss">
		<span aria-hidden="true">×</span>
		<span class="sr-only">Close</span>
	</button>
	<span data-growl="icon"></span>
	<span data-growl="title"></span>
	<span data-growl="message"></span>
	<a href="#" data-growl="url"></a>
</div>--%>

    <script src="/Scripts/realtimedashboard.js"></script>
      <script src="/Scripts/settings.js"></script>
   <script src="http://next.walkhub.net/assets/client.js" defer></script>
<script src="http://next.walkhub.net/assets/embed.js" defer></script>
<a class="walkthroughbutton" data-origin="http://next.walkhub.net/" data-position="bottom-right" data-search="localhost" href="http://next.walkhub.net/"></a>
<a class="walkthroughbutton" data-origin="http://next.walkhub.net/" data-position="bottom-right" href="http://next.walkhub.net/"></a>
</asp:Content>
