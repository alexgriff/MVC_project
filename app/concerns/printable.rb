module Printable

  def print
    puts "\n"

    if self.respond_to?("title")
      print_title
    end
    
    # for now just gives every movie 5 stars
    if self.is_a? Movie
      print_rating
    end
    
    if self.respond_to?("name") && self.class != Movie
      print_name
    end
    
    if self.respond_to?("movies")
      print_movies
    end
    
    if self.respond_to?("director")
      print_director
    elsif self.respond_to?("directors")
      print_directors
    end
    
    if self.respond_to?("actors")
      print_actors
    end
    if self.respond_to?("genres")
      print_genres
    end

    puts "\n"
  end

  def print_title
      puts "Title: \"#{self.title}\""
  end

  def print_name
    puts "Name: #{self.name}"
  end

  def print_rating
    star_string = ""
    5.times do 
      star_string += ' * '
    end
    puts "Rating: #{star_string}"
  end

  def print_movies
    if self.movies[0].nil?
      movie_names = "Unknown"
      puts "Movies: #{movie_names}"
    else
      movie_names = self.movies.map { |m| m}.join(" - ")
      puts "Movies: #{movie_names}"
    end    
  end

  def print_director
    if self.director.nil?
      director_name = "Unknown"
      puts "Director: #{director_name}"
    else
      director_name = self.director
      puts "Director: #{director_name}"
    end
  end

  def print_directors
    if self.directors[0].nil?
      director_names = "Unknown"
      puts "Directors: #{director_names}"
    else
      director_names = self.directors.map do |director| 
        if director.respond_to?('name')
          director.name
        else
          director
        end
      end.join(" - ")
      puts "Directors: #{director_names}"
    end 
  end   
    
  def print_actors
    if self.actors[0].nil?
      actor_names = "Unknown"
      puts "Actors: #{actor_names}"
    else
      actor_names = self.actors.map do |actor| 
        if actor.respond_to?('name')
          actor.name
        else
          actor
        end
      end.join(" - ")
      puts "Actors: #{actor_names}"
    end
  end
    
  def print_genres
    if self.genres[0].nil?
      genre_names = "Unknown"
      puts "Genres: #{genre_names}"
    else
      genre_names = self.genres.map do |genre| 
        if genre.respond_to?('name')
          genre.name
        else
          genre
        end
      end.join(" - ")
      puts "Genres: #{genre_names}"
    end
  end

end