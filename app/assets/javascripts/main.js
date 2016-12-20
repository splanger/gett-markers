$( document ).ready(function() {
    // Initialize data
    var drivers = [];

    var drivers_list = $("#drivers-list").find('option')
    drivers_list.each(function() {
        drivers.push(
            {
                id: $(this).val(),
                name: $(this).text(),
                license_number: $(this).attr('license_number')
            }
        )
    });

    var current_driver = {
        id: drivers_list[0].value,
        name: drivers_list[0].text,
        license_number: drivers_list[0].attributes['license_number'].value
    };


    console.log(drivers);
    console.log('Current driver:');
    console.log(current_driver);
});