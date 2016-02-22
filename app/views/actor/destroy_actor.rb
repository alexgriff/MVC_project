class DestroyActorView
    def render(actor)
        if actor.nil?
            view = ActorNotFound.new
            view.render
        else
            actor.delete
            puts "You have deleted #{actor.name} from your database"
        end
    end
end