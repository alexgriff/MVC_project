require 'pry'

class Genre < InteractiveRecord
  extend Findable
  include Populate
  include Printable
  include Deletable

  # attr_accessor :name, :movies, :directors, :actors
  # attr_reader :id


  def self.all
    rows = DB[:conn].execute("SELECT * FROM genres")
    rows.map {|row| Genre.object_from_row(row)}
  end


  def initialize(attributes = {})
    super
    @name = name
    @movies = []
    @directors = []
    @actors = []
    @id = nil
  end

  def add_movie(title)
    # self.movies << title
    sql = <<-SQL
      INSERT INTO movies_genres (movie_id, genre_id)
      VALUES (?,?)
    SQL
    DB[:conn].execute(sql, movie.id, self.id)    
  end


  def actors
    sql = <<-SQL
      SELECT actors.name FROM actors
      INNER JOIN actors_genres ON actors_genres.actor_id = actors.id
      WHERE actors_genres.genre_id = ?
    SQL
    info_hashes = DB[:conn].execute(sql, self.id).uniq
    info_hashes.map { |row_hash| row_hash.values.first }
  end

  def movies
    sql = <<-SQL
      SELECT movies.title FROM movies
      INNER JOIN movies_genres ON movies_genres.movie_id = movies.id
      WHERE movies_genres.genre_id = ?
    SQL
    info_hashes = DB[:conn].execute(sql, self.id).uniq
    info_hashes.map { |row_hash| row_hash.values.first }
  end

  def directors
    sql = <<-SQL
      SELECT directors.name FROM directors
      INNER JOIN directors_genres ON directors_genres.director_id = directors.id
      WHERE directors_genres.genre_id = ?
    SQL
    info_hashes = DB[:conn].execute(sql, self.id).uniq
    info_hashes.map { |row_hash| row_hash.values.first }
  end

end
