class DestroyGenreView
    def render(genre)
        if genre.nil?
            view = GenreNotFound.new
            view.render
        else
            genre.delete
            puts "You have deleted #{genre.name} from your database"
        end
    end
end