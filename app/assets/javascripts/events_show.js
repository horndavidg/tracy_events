$(".events.show").ready(function() {

	//Adding a photo
	$("#add_photos_button").click(function(e) {
		e.preventDefault()
		if($("#helper_div").attr("display") !== "none") {
			$( "#photo_drop_down" ).slideToggle( "fast" )
			$("#helper_div").toggleClass("slide")
			// $("#helper_div").attr("display", "none")
		}
		

	})


	//Adding a comment
	$("#add_comments_button").click(function(e) {
		e.preventDefault()
		// if($("#add_photo_button").attr("display") === "none" && $("#helper_div").attr("display") !== "none") {
			console.log("HELLO")
			$( "#comment_drop_down" ).slideToggle( "fast" )	
		// }
		
		
	})


})