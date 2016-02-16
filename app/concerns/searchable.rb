module Searchable


  # Movie.search_by("genres", "western")
  def search_by(resource, name)
    self.all.select do |movie| 
      movie_resource = movie.send(resource)
      if movie_resource.is_a? Array
        movie_resource.map {|elem| elem.name == name}
      else
        movie_resource.name == name
      end 
    end
  end

  # Movie.cross_reference("actors", "Bill Murray", "director", "Wes Anderson")
  # returns an array
  def cross_reference(aspect1, name1, aspect2, name2)
    self.search_by(aspect1, name1) & self.search_by(aspect2, name2)
  end

  # def find_incomplete
  #   self.all.select do |movie|
  #     movie.director == "Unknown" || movie.actors == [] || movie.genres == []
  #   end
  # end


  def find_and_delete(object, movie)
    #
    object.movies.size > 1 ? object.movies.delete(movie) : self.all.delete(object)
  end

  def delete(title)
    doomed_film = Movie.find_by_name(title)
    Director.find_and_delete(doomed_film.director, title)
    doomed_film.actors.each { |name| Actor.find_and_delete(name, title) }
    doomed_film.genres.each { |name| Genre.find_and_delete(name, title) }
    self.all.delete(doomed_film)
    "#{title} has been deleted from your movie collection"
  end


end