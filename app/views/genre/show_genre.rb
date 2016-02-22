class ShowGenreView
    def render(genre)
        if genre.nil?
            view = GenreNotFound.new
            view.render
        else
            genre.print
        end
    end
end