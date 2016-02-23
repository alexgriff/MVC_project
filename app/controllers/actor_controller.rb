class ActorController
    def action_prompt
        view = ActionView.new
        view.render
    end
    
    def create_name_prompt
        view = ActorCreateNameView.new
        view.render
    end
    
    def create_actor(name)
        Actor.create(name)
    end
    
    def find_actor(name)
        Actor.find_by(name: name)
    end
    
    def show_actor_prompt
        view = ShowActorPromptView.new
        view.render
    end
    
    def show_actor(name)
        view = ShowActorView.new
        view.render(name)
    end
    
    def show_all_actors
        Actor.all
    end
    
    def associate_actor_prompt
        view = AssociateActorPromptView.new
        view.render
    end
    
    def associate_actor_title
        view = AssociateActorTitleView.new
        view.render
    end
    
    def associate_actor_with_movie(actor, mov_title)
        movie = Movie.find_or_create_by(title: mov_title)
        movie.add_actor(actor)
    end
    
    def destroy_actor_name_prompt
        view = ActorDestroyNameView.new
        view.render
    end
    
    def destroy_actor(actor)
        view = DestroyActorView.new
        view.render(actor)
    end
    
end