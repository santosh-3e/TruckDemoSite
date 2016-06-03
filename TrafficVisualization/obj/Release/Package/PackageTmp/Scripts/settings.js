//$(document).ready(function () {
//    $("#realtimeprocess").click(function () {
//        StartRealTimeProcess();
//    });
//    $scope.tooltip();
   
//});

$(document).ready(function () {

    var switchs = $(".bootstrap-switch");
    console.log(switchs);

    $(switchs[0]).popover({
        //title: 'Popup First', 
        //trigger: 'hover',
        container:'body',
        placement: 'bottom',
        content: 'Click here to start and stop the demo!'
    });

    $(switchs[1]).popover({
        //title: 'Popup Second',
        // trigger: 'hover',
        container: 'body',
        placement: 'bottom',
        content: 'You can change positive or negative readings from here!'
    });

    setTimeout(function () {
        $(switchs[0]).popover("show");
        setTimeout(function () {
            ShowAnotherPopover();
        },2000);
    }, 2000);

    function ShowAnotherPopover() {
        $(switchs[0]).popover("hide");
        $(switchs[1]).popover("show");
        setTimeout(function () {
            $(switchs[1]).popover("hide");
        }, 3000);
    }

});

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

