var sun_img = 'url(http://www.highcharts.com/demo/gfx/sun.png)';
var snow_img = 'url(http://www.highcharts.com/demo/gfx/snow.png)';

//categories
var chart1_categories = ['9/2/2014 20:00', '9/4/2014 8:00', '9/4/2014 16:00'];
var chart2_categories = ['9/2/2014 20:00',
                         '9/4/2014 8:00',
                         '9/4/2014 16:00',
                         '10/6/2014 0:00',
                         '10/16/2014 20:00',
                         '10/22/2014 16:00',
                         '10/23/2014 4:00'];



//data series
var chart1_dataSeries = [{
    name: '14575188',
    marker: { symbol: 'circle' },
    data: [{
        y: 49, marker: { symbol: sun_img }
    }, 38, 99]
}, {
    name: '478450692',
    marker: {
        symbol: 'diamond'
    },
    data: [15, {
        y: 5,
        marker: {
            symbol: snow_img
        }
    }, 39]
}, {
    name: '943909725',
    marker: {
        symbol: 'square'
    },
    data: [18, 14, {
        y: 38,
        marker: {
            symbol: sun_img
        }
    }]
}];

var chart2_dataSeries = [{
    name: '14575188',
    marker: { symbol: 'circle' },
    data: [49, 38, 99, 61, 41, 40, 77]
}, {
    name: '478450692',
    marker: {
        symbol: 'diamond'
    },
    data: [15,46,39,67,55,95,33]
}, {
    name: '943909725',
    marker: {
        symbol: 'square'
    },
    data: [18,36,38,86,31,45]
}];


$(function () {
    $('#chart1').highcharts({
        chart: {
            type: 'spline'
        },
        title: {
            text: 'Truck#843825644 Temperature Analysis'
        },
        subtitle: {
            text: 'Sensor wise'
        },
        xAxis: {
            categories: chart1_categories
        },
        yAxis: {
            title: {
                text: 'Temperature'
            },
            labels: {
                formatter: function () {
                    return this.value + '°';
                }
            }
        },
        tooltip: {
            crosshairs: true,
            shared: true
        },
        plotOptions: {
            spline: {
                marker: {
                    radius: 4,
                    lineColor: '#666666',
                    lineWidth: 1
                }
            }
        },
        series: chart1_dataSeries
    });

    //Chart 2
    $('#chart2').highcharts({
        chart: {
            type: 'spline'
        },
        title: {
            text: 'Truck#843825644 Temperature Analysis'
        },
        subtitle: {
            text: 'Sensor wise'
        },
        xAxis: {
            categories: chart2_categories
        },
        yAxis: {
            title: {
                text: 'Temperature'
            },
            labels: {
                formatter: function () {
                    return this.value + '°';
                }
            }
        },
        tooltip: {
            crosshairs: true,
            shared: true
        },
        plotOptions: {
            spline: {
                marker: {
                    radius: 4,
                    lineColor: '#666666',
                    lineWidth: 1
                }
            }
        },
        series: chart2_dataSeries
    });


});
