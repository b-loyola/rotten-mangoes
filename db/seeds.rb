# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

movies = OMDB.search('2016')
movies.each do |movie|
	m = OMDB.id(movie.imdb_id)
	runtime, unit = m.runtime.split(" ")
	runtime *= 60 if unit == "h"
	m2 = Movie.create(
		title: m.title, 
		director: m.director, 
		runtime_in_minutes: m.runtime.to_i, 
		description: m.plot, 
		remote_poster_url: m.poster,
		release_date: DateTime.parse(m.released)
	)
end