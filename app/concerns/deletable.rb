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
    sql = "DELETE FROM directors WHERE id = ?"
    DB[:conn].execute(sql, self.id)
  end

  def actor_delete
    sql = "DELETE FROM actors WHERE id = ?"
    DB[:conn].execute(sql, self.id)
  end

  def genre_delete
    sql = "DELETE FROM genres WHERE id = ?"
    DB[:conn].execute(sql, self.id)
  end

  def movie_delete
    sql = "DELETE FROM movies WHERE id = ?"
    DB[:conn].execute(sql, self.id)
  end
 


end