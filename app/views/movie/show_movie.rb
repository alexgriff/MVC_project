class ShowMovieView
    def render(movie)
        if movie.nil?
            view = MovieNotFound.new
            view.render
        else
            movie.print
        end
    end
end