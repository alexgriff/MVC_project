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
    id_nums.each { |num| DB[:conn].execute(sql, num) }
    binding.pry
  end

  # def cross_ref_genres_directors
  #   # GET GENRE IDs ASSSOC. WITH DIRECTOR
  #   #  [{"genre_id"=>1, 0=>1}, {"genre_id"=>4, 0=>4}]
  #   sql = <<-SQL
  #     SELECT genre_id FROM movies_genres
  #     INNER JOIN movies ON movies.id = movies_genres.movie_id
  #     WHERE movies.director_id = ?
  #   SQL
  #   id_hash = DB[:conn].execute(sql, genre.id)
  #   id_nums = id_hash.map { |row_hash| row_hash.values.first }
  #   sql = <<-SQL
  #     INSERT INTO directors_genres (director_id,genre_id)
  #     VALUES (?, ?)
  #   SQL
  #   id_nums.each { |num| DB[:conn].execute(sql, num) }
  #   binding.pry
  # end

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
    binding.pry
    cross_ref_directors_genres(director)

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
    # genre.directors = genre.populate("director", "genres")
    # genre.actors = genre.populate("actors", "genres")
    # cross_ref_directors_genres
  end

  def name
    @title
  end


end
