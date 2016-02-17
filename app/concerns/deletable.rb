module Deletable

  def delete
    if self.is_a? Actor
      actor_delete
    elsif self.is_a? Genre
      genre_delete
    elsif self.is_a? Director
      director_delete
    elsif self.is_a? Movie
      movie_delete
    end
  end

  def director_delete
    # look through self.movies and for each use the 
    # title to get back to the Movie object
    self.movies.each do |title|
      movie = Movie.find_by_name(title)

      # on the Movie object erase self
      movie.director = nil

      # call populate on each genre and each actor
      movie.genres.each do |genre|
        genre.directors = genre.populate("director", "genres")
      end

      movie.actors.each do |actor|
        actor.directors = actor.populate("director", "actors")
      end
    end

    # finally, erase self
    self.class.all.delete(self)
  end

  def actor_delete
    # look through self.movies and for each use the 
    # title to get back to the Movie object
    self.movies.each do |title|
      movie = Movie.find_by_name(title)

      # on the Movie object erase self
      movie.actors.reject! { |a| a == self }

      # call populate on each genre and each director
      movie.genres.each do |genre|
        genre.actors = genre.populate("actors", "genres")
      end

      director = movie.director
      if director
        director.actors = director.populate("actors", "directors")
      end
    end

    # finally, erase self
    self.class.all.delete(self)
  end

  def genre_delete
    # look through self.movies and for each use the 
    # title to get back to the Movie object
    self.movies.each do |title|
      movie = Movie.find_by_name(title)

      # on the Movie object erase self
      movie.genres.reject! { |g| g == self }

      # call populate on each actor and each director
      movie.actors.each do |actor|
        actor.genres = actor.populate("genres", "actors")
      end

      director = movie.director
      if director
        director.genres = director.populate("genres", "directors")
      end
    end

    # finally, erase self
    self.class.all.delete(self)
  end

  def movie_delete
    self.director.delete
    self.actors.each { |a| a.movies.reject! {|t| t = self.title} }
    self.genres.each { |g| g.movies.reject! {|t| t = self.title} }

    self.class.all.delete(self)
  end
 


end