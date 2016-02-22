require 'pry'

class Actor < InteractiveRecord
  extend Findable
  include Populate
  include Printable
  include Deletable

  attr_accessor :name, :movies, :genres, :directors

  @@all=[]

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @@all << self
    @movies = []
    @genres = []
    @directors = []
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
    self.movies << title
  end

end