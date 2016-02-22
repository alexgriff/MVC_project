class ShowDirectorView
    def render(director)
        if director.nil?
            view = DirectorNotFound.new
            view.render
        else
            director.print
        end
    end
end