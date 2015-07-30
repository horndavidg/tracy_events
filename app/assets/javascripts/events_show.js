// $(document).on("page:load", function() {
// 	console.log("Hello")
// 	//Adding a photo
// 	$("#add_photos_button").click(function(e) {
// 		e.preventDefault()
// 		if($("#helper_div").attr("display") !== "none") {
// 			$( "#photo_drop_down" ).slideToggle( "fast" )
// 			$("#helper_div").toggleClass("slide")
// 			// $("#helper_div").attr("display", "none")
// 		}
		

// 	})


// 	//Adding a comment
// 	$("#add_comments_button").click(function(e) {
// 		e.preventDefault()
// 		// if($("#add_photo_button").attr("display") === "none" && $("#helper_div").attr("display") !== "none") {
// 			console.log("HELLO")
// 			$( "#comment_drop_down" ).slideToggle( "fast" )	
// 		// }
		
		
// 	})


// })

// $(".events.show").ready(function() {
// console.log("hello")
// 	//Adding a photo
// 	$("#add_photos_button").click(function(e) {
// 		e.preventDefault()
// 		if($("#helper_div").attr("display") !== "none") {
// 			$( "#photo_drop_down" ).slideToggle( "fast" )
// 			$("#helper_div").toggleClass("slide")
// 			// $("#helper_div").attr("display", "none")
// 		}
		

// 	})


// 	//Adding a comment
// 	$("#add_comments_button").click(function(e) {
// 		e.preventDefault()
// 		// if($("#add_photo_button").attr("display") === "none" && $("#helper_div").attr("display") !== "none") {
// 			console.log("HELLO")
// 			$( "#comment_drop_down" ).slideToggle( "fast" )	
// 		// }
		
		
// 	})


// })







var ready;
ready = function() {


	//Adding a photo**********************************************
	//Dropdown for photo form
	$("#add_photos_button").click(function(e) {
		e.preventDefault()

		if($("#helper_div").attr("display") !== "none" && !$("#helper_div").hasClass("slide")) {
			$("#helper_div").addClass("slide")
				$("#photo_drop_down").slideDown("slow")
		} else if ($("#helper_div").hasClass("slide")) {
			$("#photo_drop_down").slideUp("slow")
			setTimeout(function() {
				$("#helper_div").removeClass("slide")
			}, 600)
		}
	})

	$("#photo_drop_down input.btn.btn-primary").click(function(e) {
		e.preventDefault()

		//Extract values from form
		var url = $("#photo_url").val()
		var description = $("#photo_description").val()

		//Client side validations
		if (!url) {
			$(".validation").hide()
			var html = '<div class="text-center alert alert-danger validation">Please upload a photo.</div>'
			$("div.container").prepend(html)
		} else if (!description) {
			$(".validation").hide()
			var html = '<div class="text-center alert alert-danger validation">Please enter a description of your photo.</div>'
			$("div.container").prepend(html)
		} else {

			$(".validation").hide()
			var data = { photo: { 	url: url,
									description: description 
								} 
						};
			//Post to comments
			var url = window.location.pathname
			var urlArr = url.split("/")
			var id = urlArr[urlArr.length -1]

			$.ajax({
			     type: 'post',
			     url: '/events/' + id + '/photos.json',
			     dataType: 'json',
			     data: data}
			   ).done(function(response) {

			//Clearing Table and Sliding Back up

			   	$("#photo_url").val("")
			   	$("#photo_description").val("")
			   	
			   	$("#photo_drop_down").slideUp("slow")
			   	setTimeout(function() {
			   		$("#helper_div").removeClass("slide")
			   	}, 600)

			   	console.log(response)
			//Putting Comment on Page

			   	html = '<div class="col-sm-6 col-md-4" style="height:300px; width:auto; max-width:300px; max-height:300px;"><div class="thumbnail" style="height:300px; width:auto; max-width:300px; max-height:300px; overflow-y: scroll;"><img src="' + response.url + '-/autorotate/yes/" class = "img-responsive" alt="Event Photo"><div class="caption"><p>' + response.description+ '</p><p>added by: <a href="users/' + response.creator_id + '">' + response.creator_name + '</a></p></div></div></div>'
			   	var test
			   	
			   	$(".photo_row").append(html).fadeIn(1500)

			   });
		}



	})


	//Adding a comment*************************************************
	//Dropdown
	$("#add_comments_button").click(function(e) {
		e.preventDefault()
		if($("#photo_drop_down").attr("display") !== "none") {
			$( "#comment_drop_down" ).slideToggle( "slow", function() {
				$("#comment_content").focus()	
			} )	
			
		}
	})

//Click the submit button

	$(".comment_submit_button").click(function(e) {
		e.preventDefault()

	//Extracting value from comments form
		var content = $(".content").val()

	//Client side validation for comments
		if (!content) {
			$(".validation").hide()
			var html = '<div class="text-center alert alert-danger validation">Please enter some content for your comment.</div>'
			$("div.container").prepend(html)
		} else {
			$(".validation").hide()
			var data = { comment: { content: content } };
			//Post to comments
			var url = window.location.pathname
			var urlArr = url.split("/")
			var id = urlArr[urlArr.length -1]

			$.ajax({
			     type: 'post',
			     url: '/events/' + id + '/comments.json',
			     dataType: 'json',
			     data: data}
			   ).done(function(response) {

			   	//Clearing Table and Sliding Back up

			   	$(".content").val("")
			   	$( "#comment_drop_down" ).slideUp( "slow" )


			   	//Putting Comment on Page

			   	var html = '<blockquote><p>' + response.content+ '</p><footer><a href="users/' + response.creator_id + '">' + response.creator_name + '</a></footer></blockquote>'
			   	$(".comment_div").prepend(html).hide().fadeIn(1500)

			   });
		}

	})


	function makeMarker(lat, long, name) {
			var myLatlng = new google.maps.LatLng(lat,long);

		    var marker = new google.maps.Marker({

		        position: myLatlng,
		        map: map,
	            title: "Event name: " + name
		          
		    });
	}
	var data
	var map
	function initialize() {
		var url = window.location.pathname
		var urlArr = url.split("/")
		var id = urlArr[urlArr.length -1]
		$.ajax({
		  type: 'GET',
		  url: '/events/' + id + '.json',
		  dataType: 'json'
		}).done(function(data) {
			event = data
			console.log(data)
				
				var mapCanvas = document.getElementById('map_canvas');
				var mapOptions = {

						scrollwheel: false,
						minZoom: 12,
				      	center: new google.maps.LatLng(data.lat, data.long),
				      	zoom: 16,
				      	mapTypeId: google.maps.MapTypeId.ROADMAP
				    };

				map = new google.maps.Map(mapCanvas, mapOptions);
				makeMarker(data.lat, data.long, data.name)
		});

		

	}


	initialize()


};

$(document).ready(ready);
$(document).on('page:load', ready);







