$(".events.show").ready(function() {
	$("#add_photos_button").click(function(e) {
		e.preventDefault()
		$( "#photo_drop_down" ).slideToggle( "slow" )
	})
})