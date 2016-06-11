//$(document).ready(function () {
//    $("#realtimeprocess").click(function () {
//        StartRealTimeProcess();
//    });
//    $scope.tooltip();
   
//});

$(document).ready(function () {
    // Instance the tour
    var tour = new Tour({
        steps: [
        {
            element: "#mystartbtn",
            title:"Start Demo",
            content: "Start the demo by clicking here.",
            placement:"bottom"
        },
        {
            element: "#truck1_link",
            title: "Truck Information",
            content: "Each Truck is carrying different types of food.",
            placement: "bottom"
        },
        {
            element: ".mylocationdiv",
            title: "Current Location Information",
            content: "Real time computation of latitude & longitude information into its geographical location."
        },
        {
            element: "#chart3",
            title: "Truck Details",
            html:"true",
            content: "Data from 6 types of sensors installed in each truck being displayed in real time<br />1.Carbon-di-oxide<br />2.Oxygen<br />3.Moisture<br />4.Ethylene<br />5.Pressure<br />6.Temperature",
            placement: "top"
        },
        {
            element: "#score_prediction",
            title: "Predictions Based On Sensor Readings",
            content: "Machine Learning scoring of data in real time to determine if the food would go bad in next 4 hours",
            placement: "left"
        }
        ],
        animation: true,
        container: "body",
        backdrop: false,
        storage: false
    });

    // Initialize the tour
    //tour.init();

    // Start the tour
  //  tour.start();
});

//$(document).ready(function () {
    
//    //$('[data-toggle="popover"]').popover({html:true});
//    var switchs = $(".bootstrap-switch");
//    console.log(switchs);

//    $(switchs[0]).popover({
//        //title: 'Popup First', 
//        //trigger: 'hover',
//        html: 'true',
//        container:'body',
//        placement: 'bottom',
//        content: 'Start the demo by clicking here.<p style="text-align:right"><a href="http://localhost:7099/#truck1_link">Next</a></p>'
//    });
    

//    $(switchs[0]).popover("hide");
//    $(switchs[1]).popover({
//        title: 'Popup Second',
//         trigger: 'hover',
//        container: 'body',
//        placement: 'bottom',
//        content: 'You can change positive or negative readings from here!'
//    });

//    setTimeout(function () {
//        $(switchs[0]).popover("show");
//        setTimeout(function () {
//            ShowAnotherPopover();
//        },2000);
//    }, 2000);

//    function ShowAnotherPopover() {
//        $(switchs[0]).popover("hide");
//        $(switchs[1]).popover("show");
//        setTimeout(function () {
//            $(switchs[1]).popover("hide");
//        }, 3000);
//    }

//});

function StartRealTimeProcess() {
    var url = "processjobs.aspx?process=realtime";
    $.ajax({
        url: url,
        type: 'GET',
        dataType: "html",
        error: function (jqXHR, textStatus, errorThrown) {
            return $('#jsonp-results').html("Error: something went wrong - " + textStatus);
        },
        success: function (data, textStatus, jqXHR) {
            var d = new Date();
            window.location.href = "/charts.aspx";
        }
    });
    
    
}

