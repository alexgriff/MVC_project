require 'pry'

class Movie < InteractiveRecord
  extend Findable
  include Printable
  include Deletable
  
  
  attr_accessor :rating, :title, :actors, :genres, :director 
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

  def self.delete_by_name(name)
    self.find_by_name
  end

  
  # UPDATE movies
  # SET director_id = (SELECT id FROM directors
  #                    WHERE name = director.name)
  # WHERE id = self.id
  def add_director(director)
    @director = director
    director.add_movie(self.title)

    # directors_genres
    # INSERT OR REPLACE INTO directors_genres (genre_id, director_id)
    # VALUES (SELECT genre_id FROM directors_genres WHERE
    # director_id = director.id, director.id)
    director.genres = director.populate("genres", "directors")
    
    # actors_directors
    # INSERT OR REPLACE INTO actors_directors (actor_id, director_id)
    # VALUES (SELECT actor_id FROM actors_directors WHERE
    # director_id = director.id, director.id)
    director.actors = director.populate("actors", "directors")
  end

  # INSERT INTO movies_actors (movie_id, director_id)
  # VALUES (self.id, SELECT id FROM directors WHERE
  # name = director.name)
  def add_actor(actor)
    self.actors << actor
    actor.add_movie(self.title)

    actor.genres = actor.populate("genres", "actors")
    actor.directors = actor.populate("director", "actors")
  end


  # INSERT INTO movies_genres (movie_id, genre_id)
  # VALUES (self.id, SELECT id FROM genres WHERE
  # name = genre.name)
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
