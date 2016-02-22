require 'pry'

class Movie < InteractiveRecord
  extend Findable
  include Printable
  include Deletable


  # attr_accessor :rating, :title, :actors, :genres, :director
  # attr_reader :id
  @@all = []

  def initialize(attributes = {})
    super
    @title = title
    # @rating = rating
    @actors = []
    @genres = []
    @@all << self
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

  def self.all
    @@all
  end

  def self.delete_by_name(name)
    self.find_by_name
  end

  def cross_ref_directors_genres(director)
    # GET GENRE IDs ASSSOC. WITH DIRECTOR
    #  [{"genre_id"=>1, 0=>1}, {"genre_id"=>4, 0=>4}]
    sql = <<-SQL
      SELECT genre_id FROM movies_genres
      INNER JOIN movies ON movies.id = movies_genres.movie_id
      WHERE movies.director_id = ?
    SQL
    id_hash = DB[:conn].execute(sql, director.id)
    id_nums = id_hash.map { |row_hash| row_hash.values.first }
    sql = <<-SQL
      INSERT INTO directors_genres (director_id,genre_id)
      VALUES (?, ?)
    SQL
    id_nums.each { |num| DB[:conn].execute(sql, director.id, num) }
  end

def cross_ref_genres_directors(genre)
    # GET GENRE IDs ASSSOC. WITH DIRECTOR
    #  [{"genre_id"=>1, 0=>1}, {"genre_id"=>4, 0=>4}]
    # sql = <<-SQL
    #   SELECT genre_id FROM movies_genres
    #   INNER JOIN movies ON movies.id = movies_genres.movie_id

    #   WHERE movies.director_id = ?
    # SQL
    # id_hash = DB[:conn].execute(sql, director.id)
    # id_nums = id_hash.map { |row_hash| row_hash.values.first }
    # sql = <<-SQL
    #   INSERT INTO directors_genres (director_id,genre_id)
    #   VALUES (?, ?)
    # SQL
    # id_nums.each { |num| DB[:conn].execute(sql, director.id, num) }

    dir_id = self.director_id
    if dir_id
      sql = "INSERT INTO directors_genres (director_id, genre_id) VALUES (?, ?)"
      DB[:conn].execute(sql, dir_id, self.id)
    end
  end
  # UPDATE movies
  # SET director_id = (SELECT id FROM directors
  #                    WHERE name = directors.name)
  # WHERE id = self.id
  # def update
  #   sql = <<-SQL
  #     UPDATE movies
  #     SET #{set_info}
  #     WHERE id = ?
  #   SQL
  #   DB[:conn].execute(sql, *values_array, self.id)
  #   self
  # end

  def add_director(director)
    # @director = director
    self.director_id = director.id
    self.update
    cross_ref_directors_genres(director)
    cross_ref_directors_actors(director)

    # director.add_movie(self.title)

    # directors_genres
    # INSERT OR REPLACE INTO directors_genres (genre_id, director_id)
    # VALUES (SELECT genre_id FROM directors_genres WHERE
    # director_id = director.id, director.id)

    # director.genres = director.populate("genres", "directors")

    # actors_directors
    # INSERT OR REPLACE INTO actors_directors (actor_id, director_id)
    # VALUES (SELECT actor_id FROM actors_directors WHERE
    # director_id = director.id, director.id)
    # director.actors = director.populate("actors", "directors")
  end

  # INSERT INTO movies_actors (movie_id, director_id)
  # VALUES (self.id, SELECT id FROM directors WHERE
  # name = director.name)
  def add_actor(actor)
    # self.actors << actor
    # actor.add_movie(self.title)
    sql = <<-SQL
      INSERT INTO movies_actors (movie_id, actor_id)
      VALUES (?,?)
    SQL
    DB[:conn].execute(sql, self.id, actor.id)

    cross_ref_actors_directors(actor)
    cross_ref_actors_genres(actor)
    # actor.genres = actor.populate("genres", "actors")
    # actor.directors = actor.populate("director", "actors")
  end


  # INSERT INTO movies_genres (movie_id, genre_id)
  # VALUES (self.id, SELECT id FROM genres WHERE
  # name = genre.name)
  def add_genre(genre)
    # self.genres << genre
    # genre.add_movie(self.title)
    sql = <<-SQL
      INSERT INTO movies_genres (movie_id, genre_id)
      VALUES (?,?)
    SQL
    DB[:conn].execute(sql, self.id, genre.id)

    cross_ref_genres_directors(genre)
    cross_ref_genres_actors(genre)
    # genre.directors = genre.populate("director", "genres")
    # genre.actors = genre.populate("actors", "genres")
    # cross_ref_directors_genres
  end

  def name
    @title
  end

  def cross_ref_actors_directors(actor)

    dir_id = self.director_id
    if dir_id
      sql = "INSERT INTO actors_directors (actor_id, director_id) VALUES (?, ?);"
      DB[:conn].execute(sql, self.id, dir_id)
    end
  end

  def cross_ref_directors_actors(director)
    # GET GENRE IDs ASSSOC. WITH DIRECTOR
    #  [{"genre_id"=>1, 0=>1}, {"genre_id"=>4, 0=>4}]
    sql = <<-SQL
      SELECT actor_id FROM movies_actors
      INNER JOIN movies ON movies.id = movies_actors.movie_id
      WHERE movies.director_id = ?
    SQL
    id_hash = DB[:conn].execute(sql, director.id)
    id_nums = id_hash.map { |row_hash| row_hash.values.first }
    sql = <<-SQL
      INSERT INTO actors_directors (director_id,actor_id)
      VALUES (?, ?)
    SQL
    id_nums.each { |num| DB[:conn].execute(sql, director.id, num) }
  end

#   CREATE TABLE actors_genres (
#   id INTEGER PRIMARY KEY,
#   actor_id INTEGER,
#   genre_id INTEGER
# );

  def cross_ref_actors_genres(actor)
    # have movie and actor
    # go to movies_genres where movie.id
    # get genre_id**s** 
    # insert the actor id and genre id

    sql = <<-SQL
      SELECT genre_id FROM movies_genres
      JOIN movies ON movies.id = movies_genres.movie_id
      WHERE movies_genres.movie_id = ?
    SQL
    id_hash = DB[:conn].execute(sql, self.id)
    id_nums = id_hash.map { |row_hash| row_hash.values.first }
    sql = <<-SQL
      INSERT INTO actors_genres (actor_id, genre_id)
      VALUES (?, ?)
    SQL
    id_nums.each { |num| DB[:conn].execute(sql, actor.id, num) }
  end

  def cross_ref_genres_actors(genre)
    # have movie and genre
    # go to movies_actors where movie.id
    # get actor_id**s** 
    # insert the genre id and actor id

    sql = <<-SQL
      SELECT actor_id FROM movies_actors
      JOIN movies ON movies.id = movies_actors.movie_id
      WHERE movies_actors.movie_id = ?
    SQL
    id_hash = DB[:conn].execute(sql, self.id)
    id_nums = id_hash.map { |row_hash| row_hash.values.first }
    sql = <<-SQL
      INSERT INTO actors_genres (actor_id, genre_id)
      VALUES (?, ?)
    SQL
    id_nums.each { |num| DB[:conn].execute(sql, num, genre.id) }
  end


end
