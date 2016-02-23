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
    rows.map {|row| Genre.object_from_row(row)}
  end

  def initialize(attributes = {})
    super
    @name = name
    @movies = []
    @genres = []
    @directors = []
    @id = nil
  end

  # SELECT id FROM movies WHERE title = ?;
  # id = DB[:conn].execute(sql, title)[0][0]
  # **** what do you do if title is not found *****
  #
  # INSERT INTO movies_actors (movie_id, actor_id)
  # VALUES (?,?);
  #
  # DB[:conn].execute(sql, id, self.id)

  def add_movie(title)
    # self.movies << title
    movie = Movie.find_or_create_by(title: title)
    movie.add_actor(self)
  end

end
