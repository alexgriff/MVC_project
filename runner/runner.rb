require_relative '../config/environment.rb'
require_relative '../tools/seed.rb'

action = ""
resource = ""
until resource == 'exit' || action == 'exit'
  puts 'what would you like to act on? (movie, director, actor, genre)'
  resource = gets.chomp.downcase

  case resource
    when "movie"
      puts "what action would you like to take: add, show, destroy, index"
      action = gets.chomp
      case action
        when "add"
          puts "what is the title of the movie you would like to create?"
          title = gets.chomp
          movie = Movie.new(title)

          puts "You created a new movie called \"#{movie.title}\"."

        when "show"
          puts "what is the title of the movie you would like to show?"
          title = gets.chomp

          movie = Movie.find_by_name(title)

          if movie.nil?
            puts "\"#{title}\" could not be found in our database. Try 'index' to see what movies we have."
          else
            movie.print_movie
          end

        when "destroy"
          puts "whats the name of the movie you would like to destroy?"
          name = gets.chomp

          Movie.delete(name)
          puts "All gone!"

        when "index"
          puts "MOVIE DATABASE\n"
          Movie.all.each { |movie| movie.print_movie}
        end

    when "director"
      puts "what action would you like to take: add, show, destroy, index"
      action = gets.chomp
      case action
        when "add"
          puts "what is the name of the director you would like to create?"
          name = gets.chomp
          director = Director.find_or_create_by_name(name)
          puts "You created a new director named \"#{director.name}\"."

          puts "Do you want to associate this director to a movie? (y/n)"
          input = gets.chomp.downcase
          case input
            when "y"
              puts "what is the name of the movie that #{director.name} directed?"
              title = gets.chomp
              movie = Movie.find_or_create_by_name(title)
              movie.add_director(director)
            end

        when "show"
          puts "what is the name of the director you would like to show?"
          name = gets.chomp

          dir = Director.find_by_name(name)

          if dir.nil?
            puts "#{name} could not be found in our database. Try 'index' to see what directors we have."
          else
            dir.print_director
          end

        when "destroy"
          puts "...... not yet implemented....."
        
        when "index"
          puts "DIRECTOR DATABASE\n"
          Director.all.each { |dir| dir.print_director}
        end 

    when "actor"
      puts "what action would you like to take: add, show, destroy, index"
      action = gets.chomp
      case action
        when "add"
          puts "what is the name of the actor you would like to create?"
          name = gets.chomp
          actor = Actor.find_or_create_by_name(name)
          puts "You created a new actor named \"#{actor.name}\"."

          puts "Do you want to associate this actor to a movie? (y/n)"
          input = gets.chomp.downcase
          case input
            when "y"
              puts "what is the name of the movie that #{actor.name} acted in?"
              title = gets.chomp
              movie = Movie.find_or_create_by_name(title)
              movie.add_actor(actor)
            end

        when "show"
          puts "what is the name of the actor you would like to show?"
          name = gets.chomp

          actor = Actor.find_by_name(name)

          if actor.nil?
            puts "#{name} could not be found in our database. Try 'index' to see what actor we have."
          else
            actor.print_actor
          end

        when "destroy"
          puts "...... not yet implemented....."
        
        when "index"
          puts "ACTOR DATABASE\n"
          Actor.all.each { |actor| actor.print_actor}
        end 
    
    when "genre"
      puts "what action would you like to take: add, show, destroy, index"
      action = gets.chomp
      case action
        when "add"
          puts "what is the name of the genre you would like to create?"
          name = gets.chomp
          genre = Genre.find_or_create_by_name(name)
          puts "You created a new genre named \"#{genre.name}\"."

          puts "Do you want to associate this genre to a movie? (y/n)"
          input = gets.chomp.downcase
          case input
            when "y"
              puts "what is the name of the movie that you would like to associate \"#{genre.name}\" to?"
              title = gets.chomp
              movie = Movie.find_or_create_by_name(title)
              movie.add_genre(genre)
            end

        when "show"
          puts "what is the name of the genre you would like to show?"
          name = gets.chomp

          genre = Genre.find_by_name(name)

          if genre.nil?
            puts "#{name} could not be found in our database. Try 'index' to see what genres we have."
          else
            genre.print_genre
          end

        when "destroy"
          puts "...... not yet implemented....."
        
        when "index"
          puts "GENRE DATABASE\n"
          Genre.all.each { |genre| genre.print_genre}
        end 
  end

end