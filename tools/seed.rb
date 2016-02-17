require 'pry'

django = Movie.new("django")

western = Genre.new("western")
drama = Genre.new("drama")

quentin = Director.new("quentin")

jamie = Actor.new("jamie foxx")
mindy = Actor.new("Mindy")
anna = Actor.new("Anna")



django.add_actor(jamie)
django.add_director(quentin)
django.add_genre(western)
django.add_actor(mindy)
django.add_actor(anna)
django.add_genre(drama)




puts "k bye"



