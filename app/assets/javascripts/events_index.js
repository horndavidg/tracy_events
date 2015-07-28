// var map = ""
$(".events.index").ready(function() {
	initialize()
})

$(document).on('page:load', function() {
	initialize()
})

function initialize() {
	var mapCanvas = document.getElementById('map_canvas');
	var mapOptions = {

			minZoom: 12,
	      	center: new google.maps.LatLng(37.72840, -121.43164),
	      	zoom: 12,
	      	mapTypeId: google.maps.MapTypeId.ROADMAP
	    };

	var map = new google.maps.Map(mapCanvas, mapOptions);

	  $.ajax({
	      type: 'GET',
	      url: '/json_events.json',
	      // data: data,
	      dataType: 'json'
	    }).done(function(data) {
	    	// console.log("hello")
	    	// console.log(data)
	    	data.forEach(function(event) {

	    		var myLatlng = new google.maps.LatLng(event.lat,event.long);

			    var marker = new google.maps.Marker({

			        position: myLatlng,
			        map: map,
	                title: "Event name: " + event.name
			          
			    });

			    var date = event.start_date.substring(0, event.start_date.length - 14)
			    var orderedDate = date.slice(5,7) + "/" + date.slice(8,10) + "/" + date.slice(0,4);

			    tableBody = $("#events_table tbody")
			    html= '<tr><td><a href="/events/' + event.id + '">' + event.name + '</a></td><td>' + orderedDate + '</td></tr>'
			    tableBody.append(html)

	    	})
	});
}










