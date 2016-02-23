require 'pry'

class Director < InteractiveRecord
  extend Findable
  include Populate
  include Printable
  include Deletable

  # attr_accessor :name, :movies, :genres, :actors
  # attr_reader :id


  def self.all
    rows = DB[:conn].execute("SELECT * FROM directors")
    rows.map {|row| Genre.object_from_row(row)}
  end

  def initialize(attributes = {})
    super
    @name = name
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
