
class MovieController
    
    def show_all_movies
        Movie.all
    end
    
    def create_movie(title)
        Movie.create(title)
    end
    
    def find_movie(mov_title)
        Movie.find_by(title: mov_title)
    end
    
    def action_prompt
        view = ActionView.new
        view.render
    end
    
    def create_title_prompt
        view = MovieCreateTitleView.new
        view.render
    end
    
    def show_title_prompt
        view = MovieShowTitleView.new
        view.render
    end
    
    def destroy_title_prompt
        view = MovieDestroyTitleView.new
        view.render
    end
    
    def destroy_movie(destroyed_movie)
        view = DestroyMovieView.new
        view.render(destroyed_movie)
    end
    
end