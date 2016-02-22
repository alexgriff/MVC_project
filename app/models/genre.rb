require 'pry'


class Genre < InteractiveRecord
  extend Findable
  include Populate
  include Printable
  include Deletable

  attr_accessor :name, :movies, :directors, :actors
  
  @@all=[]

  def self.all
    @@all
  end


  def initialize(name)
    @name = name
    @@all << self
    @movies = []
    @directors = []
    @actors = []
  end

 
  # SELECT id FROM movies WHERE title = ?;
  # id = DB[:conn].execute(sql, title)[0][0]
  # **** what do you do if title is not found *****
  #
  # INSERT INTO movies_genres (movie_id, genre_id)
  # VALUES (?,?);
  #
  # DB[:conn].execute(sql, id, self.id)
  def add_movie(title)
    self.movies << title
  end 

end
