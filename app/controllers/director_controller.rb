class DirectorController
    
    def action_prompt
        view = ActionView.new
        view.render
    end
    
    def create_name_prompt
        view = DirectorCreateNameView.new
        view.render
    end
    
    def create_director(name)
        Director.create(name)
    end
    
    def find_director(name)
        Director.find_by(name: name)
    end
    
    def show_director_prompt
        view = ShowDirectorPromptView.new
        view.render
    end
    
    def show_director(name)
        view = ShowDirectorView.new
        view.render(name)
    end
    
    def show_all_directors
        Director.all
    end
    
    def associate_director_prompt
        view = AssociateDirectorPromptView.new
        view.render
    end
    
    def associate_director_title
        view = AssociateDirectorTitleView.new
        view.render
    end
    
    def associate_director_with_movie(director, mov_title)
        movie = Movie.find_or_create_by(title: mov_title)
        movie.add_director(director)
    end
    
    def destroy_director_name_prompt
        view = DirectorDestroyNameView.new
        view.render
    end
    
    def destroy_director(director)
        view = DestroyDirectorView.new
        view.render(director)
    end
    
end