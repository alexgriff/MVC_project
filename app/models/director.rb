require 'pry'

class Director < InteractiveRecord
  extend Findable
  include Populate
  include Printable
  include Deletable

  # attr_accessor :name, :movies, :genres, :actors
  # attr_reader :id

  @@all=[]

  def self.all
    @@all
  end

  def initialize(name: )
    super
    @name = name
    @@all << self
    @movies = []
    @genres = []
    @actors = []
    @id = nil
  end

  # INSERT INTO movies ()

  def add_movie(title)
    # self.movies << title
    movie = Movie.find_or_create_by(title: title)
    movie.add_director(self)
  end

end
