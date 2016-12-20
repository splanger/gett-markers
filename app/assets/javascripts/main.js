$( document ).ready(function() {
    // Initialize data
    var drivers = [];

    $("#drivers-list").find('option').each(function() {
        drivers.push(
            {
                id: $(this).val(),
                name: $(this).text(),
                license_number: $(this).attr('license_number')
            }
        )
    });

    console.log(drivers)
});