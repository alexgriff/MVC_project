require 'pry'

class Actor < InteractiveRecord
  extend Findable
  include Populate
  include Printable
  include Deletable

  # attr_accessor :name, :movies, :genres, :directors
  # attr_reader :id


  def self.all
    rows = DB[:conn].execute("SELECT * FROM actors")
    rows.map {|row| Actor.object_from_row(row)}
  end

  def initialize(attributes = {})
    super
    @name = name
    @movies = []
    @genres = []
    @directors = []
    @id = nil
  end

  def add_movie(title)
    # self.movies << title
    movie = Movie.find_or_create_by(title: title)
    movie.add_actor(self)
  end


def movies
   sql = <<-SQL
     SELECT movies.title FROM movies
     INNER JOIN movies_actors ON movies_actors.movie_id = movies.id
     WHERE movies_actors.actor_id = ?
   SQL
   info_hashes = DB[:conn].execute(sql, self.id).uniq
   info_hashes.map { |row_hash| row_hash.values.first }
 end

 def directors
   sql = <<-SQL
     SELECT directors.name FROM directors
     INNER JOIN actors_directors ON actors_directors.director_id = directors.id
     WHERE actors_directors.actor_id = ?
   SQL
   info_hashes = DB[:conn].execute(sql, self.id).uniq
   info_hashes.map { |row_hash| row_hash.values.first }
 end

 def genres
   sql = <<-SQL
   SELECT genres.name FROM genres
   INNER JOIN actors_genres ON actors_genres.genre_id = genres.id
   WHERE actors_genres.actor_id = ?
   SQL
   info_hashes = DB[:conn].execute(sql, self.id).uniq
   info_hashes.map { |row_hash| row_hash.values.first }
 end


end
