require 'pry'


django = Movie.create(title: "Django")
western = Genre.create(name: "Western")
drama = Genre.create(name: "Drama")
quentin = Director.create(name: "Quentin")
jamie = Actor.create(name: "Jamie Foxx")
mindy = Actor.create(name: "Mindy")
anna = Actor.create(name: "Anna")

django.add_director(quentin)
django.add_genre(western)
django.add_actor(jamie)
django.add_actor(mindy)
django.add_actor(anna)
django.add_genre(drama)

late_spring = Movie.create(title: "Late Spring")
setsuko = Actor.create(name: "Setsuko Hara")
chisu = Actor.create(name: "Chishu Ryu")
ozu = Director.create(name: "Ozu")

late_spring.add_genre(drama)
late_spring.add_actor(setsuko)
late_spring.add_actor(chisu)
late_spring.add_director(ozu)

heavenly = Movie.create(title: "Heavenly Creatures")
kate = Actor.create(name: "Kate Winslet")
p_j = Director.create(name: "Peter Jackson")
bio = Genre.create(name: "Biography")
crime = Genre.create(name: "Crime")

heavenly.add_actor(kate)
heavenly.add_director(p_j)
heavenly.add_genre(drama)
heavenly.add_genre(bio)
heavenly.add_genre(crime)

tokyo = Movie.create(title: "Tokyo Story")

tokyo.add_director(ozu)
tokyo.add_actor(chisu)
tokyo.add_genre(drama)

k_f_p = Movie.create(title: "Kung Fu Panda")
jack = Actor.create(name: "Jack Black")
comedy = Genre.create(name: "Comedy")
animation = Genre.create(name: "Animation")

k_f_p.add_actor(jack)
k_f_p.add_genre(comedy)
k_f_p.add_genre(animation)



# binding.pry
puts "k bye"
