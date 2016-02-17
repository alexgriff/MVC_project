require 'pry'

class Director 
  extend Findable
  include Populate
  include Printable
  include Deletable

  attr_accessor :name, :movies, :genres, :actors

  @@all=[]

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @@all << self
    @movies = []
    @genres = []
    @actors = []
  end

  def add_movie(title)
    self.movies << title
  end

end
