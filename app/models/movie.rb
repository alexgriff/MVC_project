require 'pry'

class Movie < InteractiveRecord
  extend Findable
  include Printable
  include Deletable
  include Populate

  def self.all
    rows = DB[:conn].execute("SELECT * FROM movies")
    rows.map {|row| Movie.object_from_row(row)}
  end

  def initialize(attributes = {})
    super
    @title = title
    # @rating = rating
    @actors = []
    @genres = []
    @director_id = nil
    @id = nil
  end

  def actors
    sql = <<-SQL
      SELECT actors.name FROM actors
      INNER JOIN movies_actors ON movies_actors.actor_id = actors.id
      WHERE movies_actors.movie_id = ?
    SQL
    info_hashes = DB[:conn].execute(sql, self.id)
    info_hashes.map { |row_hash| row_hash.values.first }
  end

  def genres
    sql = <<-SQL
      SELECT genres.name FROM genres
      INNER JOIN movies_genres ON movies_genres.genre_id = genres.id
      WHERE movies_genres.movie_id = ?
    SQL
    info_hashes = DB[:conn].execute(sql, self.id)
    info_hashes.map { |row_hash| row_hash.values.first }
  end

  def director
    sql = <<-SQL
      SELECT directors.name FROM directors
      INNER JOIN movies ON movies.director_id = directors.id
      WHERE directors.id = ?
    SQL
     DB[:conn].execute(sql, self.director_id)[0][0]
  end

  def self.delete_by_name(delete_name)
    #
  end

  def add_director(director)
    self.director_id = director.id
    self.update
    populate_directors_genres_from_add_director(director)
    populate_actors_directors_from_add_director(director)
  end

  def add_actor(actor)
    sql = <<-SQL
      INSERT INTO movies_actors (movie_id, actor_id)
      VALUES (?,?)
    SQL
    DB[:conn].execute(sql, self.id, actor.id)
    populate_actors_directors_from_add_actor(actor)
    populate_actors_genres_from_add_actor(actor)
  end


  def add_genre(genre)
    sql = <<-SQL
      INSERT INTO movies_genres (movie_id, genre_id)
      VALUES (?,?)
    SQL
    DB[:conn].execute(sql, self.id, genre.id)
    populate_directors_genres_from_add_genre(genre)
    populate_actors_genres_from_add_genre(genre)
  end

  def name
    @title
  end

end
