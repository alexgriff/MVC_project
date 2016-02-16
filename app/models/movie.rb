require 'pry'

class Movie
  extend Findable
  extend Searchable
  
  attr_accessor :rating
  attr_reader :title, :actors, :genres, :director 
  @@all = []

  def initialize(title, rating = 5)
    @title = title
    @rating = rating
    @actors = []
    @genres = []
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end


  def add_director(director)
    @director = director
    director.add_movie(self.title)

    director.genres = director.populate("genres", "directors")
    director.actors = director.populate("actors", "directors")
  end

  def add_actor(actor)
    self.actors << actor
    actor.add_movie(self.title)

    actor.genres = actor.populate("genres", "actors")
    actor.directors = actor.populate("director", "actors")
  end

  def add_genre(genre)
    self.genres << genre
    genre.add_movie(self.title)
    
    genre.directors = genre.populate("director", "genres")
    genre.actors = genre.populate("actors", "genres")
  end

  def print_movie
    puts "\n"
    
    #Title
    puts "Title: \"#{self.title}\""

    #Rating
    star_string = ""
    self.rating.times do 
      star_string += ' * '
    end
    puts "Rating: #{star_string}"

    #Director
    if self.director.nil?
      director_name = "Unknown"
      puts "Director: #{director_name}"
    else
      director_name = self.director.name
      puts "Director: #{director_name}"
    end
    
    #Actor
    if self.actors[0].nil?
      actor_names = "Unknown"
      puts "Actors: #{actor_names}"
    else
      actor_names = self.actors.map { |a| a.name}.join(" - ")
      puts "Actors: #{actor_names}"
    end
    
    #Genre
    if self.genres[0].nil?
      genre_names = "Unknown"
      puts "Genres: #{genre_names}"
    else
      genre_names = self.genres.map { |g| g.name}.join(" - ")
      puts "Genres: #{genre_names}"
    end

    puts "\n"
  end


  def name
    @title
  end


end
