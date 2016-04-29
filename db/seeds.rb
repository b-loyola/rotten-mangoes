# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

collection = Imdb::Top250.new
collection.movies.each_with_index do |m,i|
	if i % 2 == 1
		puts "#{i}: #{m.title}"
		Movie.create(
			title: m.title[/\d+\.\n\s+(.+)/,1], 
			director: m.director.join(", "), 
			runtime_in_minutes: m.length.to_i, 
			description: m.plot_summary, 
			remote_poster_url: m.poster,
			release_date: m.release_date
		)
	end
end