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
	var name = $(".name").val()
	var start_date = $(".start_date").val()
	var end_date = $(".end_date").val()
	var start_time = $(".start_time").val()
	var end_time = $(".end_time").val()
	var address = $(".address").val()
	var description = $(".description").val()

	if (!name) {
		console.log("name cant be blank")
	} 
	
	// var data = {event: 	{	name: name, 
	// 						start_date: start_date,
	// 						end_date: end_date,
	// 						start_time: start_time,
	// 						end_time: end_time,
	// 						address: address,
	// 						description: description
	// 			 		}
	// 			};
	// $.ajax({
	//      type: 'post',
	//      url: '/events.json',
	//      dataType: 'json',
	//      data: data}
	//    ).done(function(response) {
	//     console.log(response)
	//    });

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

	    		makeMarker(event.lat, event.long)

			    var date = event.start_date.substring(0, event.start_date.length - 14)
			    var orderedDate = date.slice(5,7) + "/" + date.slice(8,10) + "/" + date.slice(0,4);

			    tableBody = $("#events_table tbody")
			    html= '<tr><td><a href="/events/' + event.id + '">' + event.name + '</a></td><td>' + orderedDate + '</td></tr>'
			    tableBody.append(html)

	    	})
	});
}

function makeMarker(lat, long) {
		var myLatlng = new google.maps.LatLng(lat,long);

	    var marker = new google.maps.Marker({

	        position: myLatlng,
	        map: map,
            title: "Event name: " + event.name
	          
	    });
}










