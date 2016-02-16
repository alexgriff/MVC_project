require 'pry'

class Genre
  extend Findable
  extend Searchable
  include Populate

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

  def print_genre
    puts "\n"
    #Name
    puts "Name: #{self.name}"

    #Movies
    if self.movies[0].nil?
      movie_names = "Unknown"
      puts "Movies: #{movie_names}"
    else
      movie_names = self.movies.map { |m| m}.join(" - ")
      puts "Movies: #{movie_names}"
    end    

    #Directors
    if self.directors[0].nil?
      director_names = "Unknown"
      puts "Directors: #{director_names}"
    else
      director_names = self.directors.map { |d| d}.join(" - ")
      puts "Directors: #{director_names}"
    end    

    #Actors
    if self.actors[0].nil?
      actor_names = "Unknown"
      puts "Actors: #{actor_names}"
    else
      actor_names = self.actors.map { |a| a}.join(" - ")
      puts "Actors: #{actor_names}"
    end    

    puts "\n"
  end
  

end
