class DestroyDirectorView
    def render(director)
        if director.nil?
            view = DirectorNotFound.new
            view.render
        else
            director.delete
            puts "You have deleted #{director.name} from your database"
        end
    end
end