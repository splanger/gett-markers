$( document ).ready(function() {
    // Initialize data
    var drivers = [];
    var metrics_names = [];

    var drivers_options = $("#drivers-list").find('option');
    drivers_options.each(function() {
        drivers.push(
            {
                id: $(this).val(),
                name: $(this).text(),
                license_number: $(this).attr('license_number')
            }
        )
    });

    var current_driver = {
        id: drivers_options[0].value,
        name: drivers_options[0].text,
        license_number: drivers_options[0].attributes['license_number'].value
    };

    var metrics_options = $("#metrics-list").find('option');
    metrics_options.each(function() {
        metrics_names.push($(this).val())
    });
    var current_metric = metrics_options[0].value;


    console.log('Drivers:');
    console.log(drivers);
    console.log('Metrics:');
    console.log(metrics_names);
    console.log('---------------------------------------------');
    console.log('Current driver:');
    console.log(current_driver);
    console.log('Current metric:');
    console.log(current_metric);
});