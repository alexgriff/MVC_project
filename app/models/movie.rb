require 'pry'

class Movie
  extend Findable
  extend Searchable
  include Printable
  
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

  def name
    @title
  end


end
