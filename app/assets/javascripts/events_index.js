$(".events.index").ready(function() {
	function initialize() {
	            //sets the long and lat of map
	            var myLatlng = new google.maps.LatLng(lat, long);

	            //options for the map
	            var myOptions = {
	                center: myLatlng,
	                zoom: 9,
	                mapTypeId: google.maps.MapTypeId.ROADMAP
	            };

	            //creates the map
	            var mymap = new google.maps.Map(document.getElementById("map_canvas"),
	                myOptions);

	            //sets min and max zoom values
	            var opt = { minZoom: 7, maxZoom: 11 };
	                mymap.setOptions(opt);

	            //creates marker
	            var marker = new google.maps.Marker({
	                position: myLatlng,
	                map: mymap,
	                title:"Hello World!"
	            });

	            //content of infowindow
	            var contentString = '<h2>I am an info window</h2>'+'<p>Hello my name is infowindow, I need more text to test how big I get</p>';

	            //creates infowindow
	            var infowindow = new google.maps.InfoWindow({
	                    content: contentString,
	            });

	            //infowindow options
	            infowindow.setOptions({maxWidth:200}); 

	            //listens for click and opens infowindow
	            google.maps.event.addListener(marker, 'click', function() {
	                 infowindow.open(mymap,marker);
	            });
	            // Bounds for UK
	            var strictBounds = new google.maps.LatLngBounds(
	                    new google.maps.LatLng(60.88770, -0.83496), 
	                    new google.maps.LatLng(49.90878, -7.69042)
	            );

	            // Listen for the dragend event
	            google.maps.event.addListener(mymap, 'dragend', function() {
	                if (strictBounds.contains(mymap.getCenter())) return;

	                // We're out of bounds - Move the map back within the bounds
	                var c = mymap.getCenter(),
	                x = c.lng(),
	                y = c.lat(),
	                maxX = strictBounds.getNorthEast().lng(),
	                maxY = strictBounds.getNorthEast().lat(),
	                minX = strictBounds.getSouthWest().lng(),
	                minY = strictBounds.getSouthWest().lat();

	                if (x < minX) x = minX;
	                if (x > maxX) x = maxX;
	                if (y < minY) y = minY;
	                if (y > maxY) y = maxY;

	                mymap.setCenter(new google.maps.LatLng(y, x));
	            });
	        }
	        initialize()
})