require 'chronic'

User.destroy_all
Event.destroy_all
Photo.destroy_all
Comment.destroy_all


u1 = User.create({
	access_token: "ya29.vgHDPPBtRoAgGYurcVsgooqYgzM00gwBzptGdjr760nrX71E7EsiYL_kLf-HMf4ZUXnv",
	refresh_token: "1/MV8AQOv3x23cN8LqTzT0rgWgk6BdH2NBi_aeM7ItfaM",
	expires_at: 1438098371,
	google_id: "106758289722569960032",
	name: "Parker",
	email: "paike09@gmail.com"
	})

u2 = User.create({
	access_token: "ya29.vgEjTWSfp9w5ZlR3r5cDHHZ2LfYzSecJMi0xsThgifxu_daVzsigaeh11xisCZfL1Oie",
	refresh_token: "1/2vuUuibY25lTQTZQXqvzo4Ntmyw_iceqrBi8CZ5qHq0",
	expires_at: 1438098721,
	google_id: "104455543317816909595",
	name: "David",
	email: "horndavidg@gmail.com"
	})

e1 = Event.create({
	creator_id: "2",
	start_date: Chronic.parse("28 Jul 2015 1pm"),
	end_date: Chronic.parse("28 Jul 2015 2pm"),
	
	start_time: "13:00",
	end_time: "14:00",
	name: "Test",
	address: "2435 Lincoln Blvd. Tracy, CA, 95376",

	lat: "37.754639",
	long: "-121.443922",
	description: "This test is a test event."
	creator_name: "David"	
	})

e2 = Event.create({
	creator_id: "2",
	start_date: Chronic.parse("29 Jul 2015 1pm"),
	end_date: Chronic.parse("29 Jul 2015 2pm"),
	start_time: "13:00",
	end_time: "14:00",
	name: "Test",
	address: "2435 Lincoln Blvd. Tracy, CA, 95376",

	lat: "37.754639",
	long: "-121.443922",
	description: "This test is a test event."
	creator_name: "David"	
	})

e3 = Event.create({
	creator_id: "1",
	start_date: Chronic.parse("29 Jul 2015 1pm"),
	end_date: Chronic.parse("29 Jul 2015 2pm"),
	start_time: "13:00",
	end_time: "14:00",
	name: "Test",
	address: "2435 Lincoln Blvd. Tracy, CA, 95376",

	lat: "37.754639",
	long: "-121.443922",
	description: "This test is a test event."
	creator_name: "Parker"	
	})

u1.events << e3
u2.events << e1
u2.events << e2

p1 = Photo.create({
	creator_id: "2",
	url: "http://cutepuppyclub.com/wp-content/uploads/2015/05/White-Cute-Puppy-.jpg",
	description: "This is a cute puppy",
	event_id: "1",
	creator_name: "David"
	})

p2 = Photo.create({
	creator_id: "2",
	url: "http://cutepuppyclub.com/wp-content/uploads/2015/05/White-Cute-Puppy-.jpg",
	description: "This is a cute puppy",
	event_id: "2",
	creator_name: "David"
	})

p3 = Photo.create({
	creator_id: "1",
	url: "http://cutepuppyclub.com/wp-content/uploads/2015/05/White-Cute-Puppy-.jpg",
	description: "This is a cute puppy",
	event_id: "3",
	creator_name: "Parker"
	})

e1.photos << p1
e2.photos << p2
e3.photos << p3

c1 = Comment.create({
	content: "This is a test comment.",
	creator_id: "2",
	event_id: "1",
	creator_name: "David"
	})

c2 = Comment.create({
	content: "This is a test comment.",
	creator_id: "2",
	event_id: "2",
	creator_name: "David"
	})

c3 = Comment.create({
	content: "This is a test comment.",
	creator_id: "1",
	event_id: "3",
	creator_name: "Parker"
	})

e1.comments << c1
e2.comments << c2
e3.comments << c3






