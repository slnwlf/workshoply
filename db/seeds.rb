# DO NOT DELETE THIS - TRUNG
users = User.create([
	{
		full_name: 'Sam Brooks', 
		email: 'sam@mail.com', 
		password: 'sam12345', 
		password_confirmation: 'sam12345',
		organization: "General Assembly",
		location: "san francisco, ca, united states",
		bio: "Ex nam senserit vituperatoribus. Nonumy vituperata an cum. Ut dicam veniam ornatus mea, no sale platonem repudiare ius, te quaeque mentitum his. Mei ex bonorum mediocrem, per at agam placerat invidunt. No etiam quodsi menandri his. Vis quaestio gubergren no, tota everti an pri. Quod solet nec ne, ei sumo everti prompta vel, nostro consequat."
	}, 
	{
		full_name: 'Dave Sloan', 
		email: 'dave@mail.com', 
		password: 'dave12345', 
		password_confirmation: 'dave12345',
		organization: "Amazon",
		location: "melo park, ca, united states",
		bio: "Lorem ipsum dolor sit amet, mei at reque salutandi, petentium sapientem deseruisse vix ea. Eam cu malis perpetua, eam ex mutat aperiri. Ad nonumy scripserit has, duo nulla sonet deterruisset ad, mei eros scriptorem cu. Erant ornatus nonumes ne mea, sed justo delectus perpetua ei."
	}, 
	{
		full_name: 'Trung Huynh', 
		email: 'trung@mail.com', 
		password: 'trung12345', 
		password_confirmation: 'trung12345',
		organization: "Amazon",
		location: "fremont, ca, united states",
		bio: "In legimus maluisset accusamus nec, sed ut munere dolorum signiferumque, id esse voluptua reprimique pri. Quo an dolores hendrerit liberavisse. Et eos petentium conclusionemque, eu duo enim feugiat. Ea inani consul aperiri mea, vim id dicit feugait, et eum ignota efficiantur. Eos aperiri lucilius ad, eum ut nostrud consectetuer voluptatibus."
	}
])

topics = Topic.create([
	{name: "teamwork"},
	{name: "leadership skills"},
	{name: "communication skills"},
	{name: "management training"},
	{name: "project management"},
	{name: "public speaking"},
	{name: "strategy / marketing"},
	{name: "presentation skills"},
	{name: "cross-cultural knowledge"},
	{name: "ethics"},
	{name: "creativity techniques"}
])

# DO NOT DELETE THIS - TRUNG
titles = ["Diam Torquatos Assueverit", "Tibique Vivendum Prodesset Id Sea", "legere corrumpit vis ne", "Legere Corrumpit Vis Ne", "Vivendum Prodess etgere Corrumpit", "Vivendum Prodess Etgere Corrumpit"]

description = 'Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo. Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque porro quisquam est, qui dolorem ipsum, quia dolor sit amet, consectetur, adipisci[ng] velit, sed quia non numquam [do] eius modi tempora inci[di]dunt, ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit, qui in ea voluptate velit esse, quam nihil molestiae consequatur, vel illum, qui dolorem eum fugiat, quo voluptas nulla pariatur'

20.times do |x|
	Workshop.create({
		title: titles[rand(1..6) - 1],
		description: description,
		location: User.find(rand(1..3)).location,
		user_id: rand(1..3),
		topic_id: rand(1..11),
	})
end