# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

workshops = Workshop.create([
	{ 
			title: 'Leadership 101',
			description: 'Learn the basis of leading a team.',
			host: 'Google'},
		{ 
			title: 'Unconscious Bias',
			description: 'Identify, explore, and ultimately shed unconscious biases that may be affecting how you relate to your co-workers.',
			host: 'Facebook'},
			{
				title: 'Team Building',
				description: 'Learn how to build effective teams, bring out the best in your teammates, and work collaboratively to accomplish big goals and solve important problems.',
				host: 'General Assembly'
			}

	])
