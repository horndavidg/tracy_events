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
			   	console.log(response)

			   	if (!response) {
			   		console.log("hello")
			   	}

			   	//Clearing Table and Sliding Back up

			   	$(".content").val("")
			   	$( "#comment_drop_down" ).slideUp( "slow" )


			   	//Putting Comment on Page

			   	var html = '<blockquote><p>' + response.content+ '</p><footer><a href="users/' + response.creator_id + '">' + response.creator_name + '</a></footer></blockquote>'
			   	$(".comments").append(html).hide().fadeIn(1500)


			 //    //putting event in table
			 //    var date = response.start_date.substring(0, response.start_date.length - 14)
			 //    var orderedDate = date.slice(5,7) + "/" + date.slice(8,10) + "/" + date.slice(0,4);

			 //    //putting event on map
			 //    makeMarker(response.lat, response.long, response.name)
			 //    var html = '<tr class="alert-success alert"><td><a href="/events/' + response.id + '">' + response.name + '</a></td><td>' + orderedDate + '</td></tr>'
			 //    $("table tbody").prepend(html)

			 //    //Clearing table values and hidding make event div
				// $( ".slide" ).slideToggle( "slow")
			 //    $(".name").val("")
			 //    $(".start_date").val("")
			 //    $(".end_date").val("")
				// $(".start_time").val("")
				// $(".end_time").val("")
				// $(".address").val("")
				// $(".description").val("")

			   });
		}

	})





	


};

$(document).ready(ready);
$(document).on('page:load', ready);







