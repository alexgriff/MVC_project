require 'pry'


django = Movie.create(title: "django")

western = Genre.create(name: "western")
drama = Genre.create(name: "drama")

quentin = Director.create(name: "quentin")

jamie = Actor.create(name: "jamie foxx")
mindy = Actor.create(name: "Mindy")
anna = Actor.create(name: "Anna")


django.add_director(quentin)
django.add_genre(western)
django.add_actor(jamie)
django.add_actor(mindy)
django.add_actor(anna)
django.add_genre(drama)

# binding.pry
puts "k bye"
