// var map = ""
$(".events.index").ready(function() {
	initialize()

	var button = $("#add_event_button")
	button.click(function(e) {
		e.preventDefault()

		$( ".slide" ).slideToggle( "slow")
	})

	$(".new_event").click(function(e) {
		e.preventDefault()
		postEvent()
	})
})

$(document).on('page:load', function() {
	initialize()
	
	var button = $("#add_event_button")
	button.click(function(e) {
		e.preventDefault()

		$( ".slide" ).slideToggle( "slow")
	})

	$(".new_event").click(function(e) {
		e.preventDefault()
		postEvent()
	})

})


function postEvent() {
// Extracting values from form
	var name = $(".name").val()
	var start_date = $(".start_date").val()
	var end_date = $(".end_date").val()
	var start_time = $(".start_time").val()
	var end_time = $(".end_time").val()
	var address = $(".address").val()
	var description = $(".description").val()

// Client side validations
	if (!name) {
		$(".validation").hide()
		var html = '<div class="text-center alert alert-danger validation">Please enter a name for this event</div>'
		$("div.container").prepend(html)
	} else if (!start_date) {
		$(".validation").hide()
		var html = '<div class="text-center alert alert-danger validation">Please enter a start_date for this event</div>'
		$("div.container").prepend(html)
	} else if (!end_date) {
		$(".validation").hide()
		var html = '<div class="text-center alert alert-danger validation">Please enter an end_date for this event</div>'
		$("div.container").prepend(html)
	} else if (!start_time) {
		$(".validation").hide()
		var html = '<div class="text-center alert alert-danger validation">Please enter a start_time for this event</div>'
		$("div.container").prepend(html)
	} else if (!end_time) {
		$(".validation").hide()
		var html = '<div class="text-center alert alert-danger validation">Please enter an end_time for this event</div>'
		$("div.container").prepend(html)
	} else if (!address) {
		$(".validation").hide()
		var html = '<div class="text-center alert alert-danger validation">Please enter an address for this event</div>'
		$("div.container").prepend(html)
	} else if (!description) {
		$(".validation").hide()
		var html = '<div class="text-center alert alert-danger validation">Please enter a description for this event</div>'
		$("div.container").prepend(html)
	} else if (!address.includes("Tracy")) {
		$(".validation").hide()
		var html = '<div class="text-center alert alert-danger validation">The address must include the word "Tracy" (case sensitive)</div>'
		$("div.container").prepend(html)
	} else {
		$(".validation").hide()
		var data = {event: 	{	name: name, 
								start_date: start_date,
								end_date: end_date,
								start_time: start_time,
								end_time: end_time,
								address: address,
								description: description
					 		}
					};
		$.ajax({
		     type: 'post',
		     url: '/events.json',
		     dataType: 'json',
		     data: data}
		   ).done(function(response) {

		    //putting event in table
		    var date = response.start_date.substring(0, response.start_date.length - 14)
		    var orderedDate = date.slice(5,7) + "/" + date.slice(8,10) + "/" + date.slice(0,4);

		    //putting event on map
		    makeMarker(response.lat, response.long, response.name)
		    var html = '<tr class="alert-success alert"><td><a href="/events/' + response.id + '">' + response.name + '</a></td><td>' + orderedDate + '</td></tr>'
		    $("table tbody").prepend(html)

		    //Clearing table values and hidding make event div
			$( ".slide" ).slideToggle( "slow")
		    $(".name").val("")
		    $(".start_date").val("")
		    $(".end_date").val("")
			$(".start_time").val("")
			$(".end_time").val("")
			$(".address").val("")
			$(".description").val("")

		   });
	}



}
var map
function initialize() {
	var mapCanvas = document.getElementById('map_canvas');
	var mapOptions = {

			minZoom: 12,
	      	center: new google.maps.LatLng(37.72840, -121.43164),
	      	zoom: 12,
	      	mapTypeId: google.maps.MapTypeId.ROADMAP
	    };

	map = new google.maps.Map(mapCanvas, mapOptions);

	  $.ajax({
	      type: 'GET',
	      url: '/json_events.json',
	      // data: data,
	      dataType: 'json'
	    }).done(function(data) {
	    	// console.log("hello")
	    	// console.log(data)
	    	data.forEach(function(event) {

	    		makeMarker(event.lat, event.long, event.name)

			    var date = event.start_date.substring(0, event.start_date.length - 14)
			    var orderedDate = date.slice(5,7) + "/" + date.slice(8,10) + "/" + date.slice(0,4);

			    tableBody = $("#events_table tbody")
			    html= '<tr><td><a href="/events/' + event.id + '">' + event.name + '</a></td><td>' + orderedDate + '</td></tr>'
			    tableBody.append(html)

	    	})
	});
}

function makeMarker(lat, long, name) {
		var myLatlng = new google.maps.LatLng(lat,long);

	    var marker = new google.maps.Marker({

	        position: myLatlng,
	        map: map,
            title: "Event name: " + name
	          
	    });
}










