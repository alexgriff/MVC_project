require 'pry'

class Director < InteractiveRecord
  extend Findable
  include Populate
  include Printable
  include Deletable

  # attr_accessor :name, :movies, :genres, :actors
  # attr_reader :id


  def self.all
    rows = DB[:conn].execute("SELECT * FROM directors")
    rows.map {|row| Director.object_from_row(row)}
  end

  def initialize(attributes = {})
    super
    @name = name
    @movies = []
    @genres = []
    @actors = []
    @id = nil
  end

  # INSERT INTO movies ()

  def movies
 +    sql = <<-SQL
 +      SELECT title FROM movies
 +      WHERE movies.director_id = ?
 +    SQL
 +    info_hashes = DB[:conn].execute(sql, self.id)
 +    binding.pry
 +    info_hashes.map { |row_hash| row_hash.values.first }
 +  end
 +
 +  def actors
 +    sql = <<-SQL
 +      SELECT name FROM actors
 +      JOIN actors_directors on actors_directors.actor_id = actors.id
 +      WHERE actors_directors.director_id = ?
 +    SQL
 +    info_hashes = DB[:conn].execute(sql, self.id)
 +    binding.pry
 +    info_hashes.map { |row_hash| row_hash.values.first }
 +  end
 +
 +  def genres
 +    sql = <<-SQL
 +      SELECT name FROM genres
 +      JOIN directors_genres on directors_genres.genre_id = genres.id
 +      WHERE directors_genres.director_id = ?
 +    SQL
 +    info_hashes = DB[:conn].execute(sql, self.id)
 +    binding.pry
 +    info_hashes.map { |row_hash| row_hash.values.first }
 +  end
 +

  def add_movie(title)
    # # self.movies << title
    # movie = Movie.find_or_create_by(title: title)
    # movie.add_director(self)
  end

  

end
