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


	//Adding a comment
	$("#add_comments_button").click(function(e) {
		e.preventDefault()
		if($("#photo_drop_down").attr("display") !== "none") {
			console.log("HELLO")
			$( "#comment_drop_down" ).slideToggle( "slow" )	
		}
		
		
	})

};

$(document).ready(ready);
$(document).on('page:load', ready);







