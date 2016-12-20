var map = null;
var drivers = [];
var markers = [];
var metrics_names = [];
var current_metric = null;
var current_driver = null;

$( document ).ready(function() {

    // Initialize data
    var drivers_list = $("#drivers-list");
    var drivers_options = drivers_list.find('option');
    drivers_options.each(function() {
        drivers.push(
            {
                id: $(this).val(),
                name: $(this).text(),
                license_number: $(this).attr('license_number')
            }
        )
    });

    current_driver = {
        id: drivers_options[0].value,
        name: drivers_options[0].text,
        license_number: drivers_options[0].attributes['license_number'].value
    };

    var metrics_list = $("#metrics-list");
    var metrics_options = metrics_list.find('option');
    metrics_options.each(function() {
        metrics_names.push($(this).val())
    });
    current_metric = metrics_options[0].value;

    console.log('Drivers:');
    console.log(drivers);
    console.log('Metrics:');
    console.log(metrics_names);
    console.log('---------------------------------------------');
    console.log('Current driver:');
    console.log(current_driver);
    console.log('Current metric:');
    console.log(current_metric);

    // Initialize the map
    render_map(current_driver, current_metric, map);

    /** ========== ATTACH LISTENERS ========== */
    drivers_list.change(function() {
        var selected_option = $(this).find('option:selected');
        current_driver = {
            id: selected_option[0].value,
            name: selected_option[0].text,
            license_number: selected_option[0].attributes['license_number'].value
        };
        $('#current-driver-name').text(current_driver.name);
        $('#current-driver-license-number').text(current_driver.license_number);
        render_map(current_driver, current_metric, map);
    });

    metrics_list.change(function() {
        var current_metric = $(this).find('option:selected').val();
        $('#current-metric-name').text(current_metric);
        render_map(current_driver, current_metric, map);
    });

});

function initialize_map() {
    console.log("initialize_map() has been invoked!");
    var mapOptions = {
        center: new google.maps.LatLng(-34.397, 150.644),
        zoom: 10,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    if (current_driver !== null && current_metric !== null && map !== null) {
        render_map(current_driver, current_metric, map);
    } else {
        setTimeout(function () {
            if (current_driver !== null && current_metric !== null && map !== nul) {
                render_map(current_driver, current_metric, map);
            } else {
                alert('Failed to Load Google Maps API :-(');
            }
        }, 1500 );
    }
}

/**
 *
 * @param current_driver An object representing currently selected driver
 * @param current_metric Currently selected metric's name
 * @param map Reference to Google Map
 */
function render_map(current_driver, current_metric, map) {
    if (map === null) {
        console.log('map has not been initialized yet...');
        return
    }

    console.log('Rendering a map of metric ' + current_metric + ' for ' + current_driver['name']);

    var endpoint = "/drivers/" + current_driver['id'] + "/metrics?metric_name=" + current_metric;
    $.ajax(endpoint, {
        success: function(metrics) {
            console.log('Got metrics');
            console.log(metrics);

            clearMarkersFromMap(markers);
            putMetricsOnMap(map, markers, metrics);

            if (metrics.length > 0) {
                var coords = new google.maps.LatLng(metrics[0].lat, metrics[0].lon);
                map.panTo(coords);
            }
        },
        error: function() {
            console.log("Failed to bring data from " + endpoint);
        }
    });
}

function clearMarkersFromMap(markers) {
    for (var i in markers) {
        markers[i].setMap(null);
    }
    markers.length = 0;
}

function putMetricsOnMap(map, markers, metrics) {
    metrics.forEach(function(metric, index) {
        var coordinates = new google.maps.LatLng(metric.lat, metric.lon);
        var marker = new google.maps.Marker({
            position: coordinates,
            map: map,
            title: "" + metric.value
        });
        markers.push(marker);
    });
}