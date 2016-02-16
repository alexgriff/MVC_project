require 'pry'

class Director 
  extend Findable
  extend Searchable
  include Populate

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

  def print_director
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

    #Genres
    if self.genres[0].nil?
      genre_names = "Unknown"
      puts "Genres: #{genre_names}"
    else
      genre_names = self.genres.map { |g| g}.join(" - ")
      puts "Genres: #{genre_names}"
    end    

    #Actors worked with 
    if self.actors[0].nil?
      actor_names = "Unknown"
      puts "Actors worked with: #{actor_names}"
    else
      actor_names = self.actors.map { |a| a}.join(" - ")
      puts "Actors worked with: #{actor_names}"
    end    

    puts "\n"
  end

end
