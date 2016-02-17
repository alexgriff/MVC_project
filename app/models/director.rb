require 'pry'

class Director 
  extend Findable
  include Populate
  include Printable

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

  # TO DO:
  # --------------------
  # def self.delete(name)
  #   dir = Director.find_by_name(name)
  #   dir.movies.each { |movie| }
  # end

end
