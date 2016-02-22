class DestroyMovieView 
    def render(destroyed_movie)
          if destroyed_movie.nil?
            view = MovieNotFound.new
            view.render
          else
            destroyed_movie.delete
            puts "#{destroyed_movie.title} has been deleted"
          end
      end
end