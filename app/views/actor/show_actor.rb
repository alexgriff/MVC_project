class ShowActorView
    def render(actor)
        if actor.nil?
            view = ActorNotFound.new
            view.render
        else
            actor.print
        end
    end
end