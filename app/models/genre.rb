require 'pry'

class Genre
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

  def add_movie(title)
    self.movies << title
  end 

end
