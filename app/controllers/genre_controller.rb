class GenreController
    
    def action_prompt
        view = ActionView.new
        view.render
    end
    
    def create_name_prompt
        view = GenreCreateNameView.new
        view.render
    end
    
    def create_genre(name)
        Genre.create(name)
    end
    
    def find_genre(name)
        Genre.find_by(name: name)
    end
    
    def show_genre_prompt
        view = ShowGenrePromptView.new
        view.render
    end
    
    def show_genre(name)
        view = ShowGenreView.new
        view.render(name)
    end
    
    def show_all_genres
        Genre.all
    end
    
    def associate_genre_prompt
        view = AssociateGenrePromptView.new
        view.render
    end
    
    def associate_genre_title
        view = AssociateGenreTitleView.new
        view.render
    end
    
    def associate_genre_with_movie(genre, title)
        movie = Movie.find_or_create_by(title: title)
        movie.add_genre(genre)
    end
    
    def destroy_genre_name_prompt
        view = GenreDestroyNameView.new
        view.render
    end
    
    def destroy_genre(genre)
        view = DestroyGenreView.new
        view.render(genre)
    end
    
end