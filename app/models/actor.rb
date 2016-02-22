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

  def add_movie(title)
    self.movies << title
  end

end