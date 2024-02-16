document.addEventListener("DOMContentLoaded", function() {
    console.log("HIIIIIIII");
    // Get references to the form fields
    var eventDateField = document.getElementById("event_date");
    var eventStartTimeField = document.getElementById("event_start_time");
    var eventEndTimeField = document.getElementById("event_end_time");
    var roomIDSelect = document.getElementById("room_id");

    // Add event listeners to the form fields
    eventDateField.addEventListener("input", logFieldChange);
    eventStartTimeField.addEventListener("input", logFieldChange);
    eventEndTimeField.addEventListener("input", logFieldChange);

    // Function to log event date to the console
    var given_date;
    var given_start_time;
    var given_end_time;
    function logFieldChange(event) {
        var fieldName = event.target.name;
        var fieldValue = event.target.value;
        console.log(fieldName + ":", fieldValue);
        if (fieldName=="event[event_date]")
            given_date=fieldValue;
        if (fieldName=="event[event_start_time]")
            given_start_time=fieldValue;
        if (fieldName=="event[event_end_time]")
            given_end_time=fieldValue;
        console.log(given_date);
        console.log(given_start_time);
        console.log(given_end_time);

        var xhr = new XMLHttpRequest();
        var url = "<%= available_rooms_path %>?date=" + encodeURIComponent(given_date) + "&start_time=" + encodeURIComponent(given_start_time) + "&end_time=" + encodeURIComponent(given_end_time);
        xhr.open("GET", url, true);
        xhr.setRequestHeader("Content-Type", "application/json");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var rooms = JSON.parse(xhr.responseText);
                console.log("Called again");
                // Clear existing options
                roomIDSelect.innerHTML = "";

                // Add new options based on the events data
                rooms.forEach(function(room) {
                    console.log(room)
                    var option = document.createElement("option");
                    option.text = room.room_location;
                    option.value = room.id;
                    roomIDSelect.add(option);

                });

            }
        };
        xhr.send();
    }
});