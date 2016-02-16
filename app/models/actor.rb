require 'pry'

class Actor
  extend Findable
  extend Searchable
  include Populate

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

  def print_actor
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

    #Genres
    if self.genres[0].nil?
      genre_names = "Unknown"
      puts "Genres: #{genre_names}"
    else
      genre_names = self.genres.map { |g| g}.join(" - ")
      puts "Genres: #{genre_names}"
    end    

    puts "\n"
  end


end