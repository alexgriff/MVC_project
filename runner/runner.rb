require_relative '../config/environment.rb'
require_relative '../tools/seed.rb'

action = ""
resource = ""
until resource == 'exit' || action == 'exit'
  puts 'what would you like to act on? (movie, director, actor, genre)'
  resource = gets.chomp.downcase

  case resource
    when "movie"
      controller = MovieController.new
      action = controller.action_prompt
      case action
        when "add"
          controller = MovieController.new
          title = controller.create_title_prompt
          
          controller = MovieController.new
          movie = controller.create_movie(title)
          
          view = ShowMovieView.new
          view.render(movie)

        when "show"
          controller = MovieController.new
          title = controller.show_title_prompt
          
          controller = MovieController.new
          movie = controller.find_movie(title)
      
          view = ShowMovieView.new
          view.render(movie)

        when "destroy"
          controller = MovieController.new
          title = controller.destroy_title_prompt
          
          
          controller = MovieController.new
          destroyed_movie = controller.find_movie(title)
          
          controller = MovieController.new
          controller.destroy_movie(destroyed_movie)
          
        when "index"
          controller = MovieController.new
          all_movies = controller.show_all_movies
          
          all_movies.each do |movie| 
            view = ShowMovieView.new
            view.render(movie)
          end
          
        end

    when "director"
      controller = DirectorController.new
      action = controller.action_prompt
      case action
        when "add"
          controller = DirectorController.new
          name = controller.create_name_prompt
          
          controller = DirectorController.new
          director = controller.create_director(name)
          
          controller = DirectorController.new
          controller.show_director(director)

          controller = DirectorController.new
          input = controller.associate_director_prompt
          
          if input == "y"
              controller = DirectorController.new
              title = controller.associate_director_title
              
              controller = DirectorController.new
              movie = controller.associate_director_with_movie(director, title)
              
              controller = DirectorController.new
              controller.show_director(director)
          end

        when "show"
          controller = DirectorController.new
          name = controller.show_director_prompt
          
          controller = DirectorController.new
          director = controller.find_director(name)
          
          controller = DirectorController.new
          controller.show_director(director)
          
        when "destroy"
          controller = DirectorController.new
          name = controller.destroy_director_name_prompt

          controller = DirectorController.new
          director = controller.find_director(name)
          
          controller = DirectorController.new
          controller.destroy_director(director)

        when "index"
          controller = DirectorController.new
          all_directors = controller.show_all_directors
          
          all_directors.each do |director|
            view = ShowDirectorView.new
            view.render(director)
          end
        end 

    when "actor"
      controller = ActorController.new
      action = controller.action_prompt
      case action
        when "add"
          controller = ActorController.new
          name = controller.create_name_prompt
          
          controller = ActorController.new
          actor = controller.create_actor(name)
          
          controller = ActorController.new
          controller.show_actor(actor)

          controller = ActorController.new
          input = controller.associate_actor_prompt

          if input == "y"
              controller = ActorController.new
              title = controller.associate_actor_title
              
              controller = ActorController.new
              movie = controller.associate_actor_with_movie(actor, title)
              
              controller = ActorController.new
              controller.show_actor(actor)
          end
        when "show"
          controller = ActorController.new
          name = controller.show_actor_prompt

          controller = ActorController.new
          actor = controller.find_actor(name)
          
          controller = ActorController.new
          controller.show_actor(actor)

        when "destroy"
          controller = ActorController.new
          name = controller.destroy_actor_name_prompt
        
          controller = ActorController.new
          actor = controller.find_actor(name)

          controller = ActorController.new
          controller.destroy_actor(actor)
          
        when "index"
        controller = ActorController.new
        all_actors = controller.show_all_actors
          
        all_actors.each do |actor|
          view = ShowActorView.new
          view.render(actor)
        end
      end
    
    when "genre"
      controller = GenreController.new
      action = controller.action_prompt
      case action
        when "add"
          controller = GenreController.new
          name = controller.create_name_prompt

          controller = GenreController.new
          genre = controller.create_genre(name)

          controller = GenreController.new
          controller.show_genre(genre)

          controller = GenreController.new
          input = controller.associate_genre_prompt

          if input == "y"
              controller = GenreController.new
              title = controller.associate_genre_title
              
              controller = GenreController.new
              movie = controller.associate_genre_with_movie(genre, title)
              
              controller = GenreController.new
              controller.show_genre(genre)
          end

        when "show"
          controller = GenreController.new
          name = controller.show_genre_prompt

          controller = GenreController.new
          genre = controller.find_genre(name)
          
          controller = GenreController.new
          controller.show_genre(genre)

        when "destroy"
          controller = GenreController.new
          name = controller.destroy_genre_name_prompt
        
          controller = GenreController.new
          genre = controller.find_genre(name)

          controller = GenreController.new
          controller.destroy_genre(genre)
        
        when "index"
          controller = GenreController.new
          all_genres = controller.show_all_genres
          
          all_genres.each do |genre|
            view = ShowGenreView.new
            view.render(genre)
          end
      end
  end

end