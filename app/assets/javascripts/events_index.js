// var map = ""
$(".events.index").ready(function() {
	initialize()
})

function initialize() {
	var mapCanvas = document.getElementById('map_canvas');
	console.log("IN HERE???")
	console.log(mapCanvas)
	// console.log(map)
	var mapOptions = {

			minZoom: 12,
	      	center: new google.maps.LatLng(37.72840, -121.43164),
	      	zoom: 12,
	      	mapTypeId: google.maps.MapTypeId.ROADMAP
	    };

	var map = new google.maps.Map(mapCanvas, mapOptions);


}


// function initialize() {
//         var mapCanvas = document.getElementById('map_canvas');
//         var mapOptions = {
//           center: new google.maps.LatLng(44.5403, -78.5463),
//           zoom: 8,
//           mapTypeId: google.maps.MapTypeId.ROADMAP
//         }
//         var map = new google.maps.Map(mapCanvas, mapOptions)
//       }
//       google.maps.event.addDomListener(window, 'load', initialize);



// $(".events.index").load(function() {
// 	console.log("hello")
// 	// var map 
// 	// function initialize() {
// 	//     // Puts the Google Map on the page, make sure it 
// 	//     // always has dimensions assigned.... 

// 	//     map = new google.maps.Map(document.getElementById('map-canvas'), {
// 	//       zoom: 2,
// 	//       center: {lat: 39.7643389, lng: -104.8551114} // Centered on Denver, CO
// 	//     });


// 	//     var mapDiv = document.getElementById('map-canvas');

// 	//     google.maps.event.addListener(map, 'click', addMarker);
	  
// 	// }
// 	// initialize()

// 	// function waitUntilDoneLoading(map_id, next) {
// 	// 	var map = document.getElementById('map-canvas');
// 	// 	console.log(map)
// 	// 	return next(map)
// 	// }

	
	


// 	// waitUntilDoneLoading("map-canvas", initialize)


// 	initialize()
// })