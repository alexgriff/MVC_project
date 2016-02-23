require 'pry'
module Populate

  def populate_directors_genres_from_add_director(director)
    sql = <<-SQL
      SELECT movies_genres.genre_id FROM movies_genres
      WHERE movies_genres.movie_id = ?
    SQL
    id_hash = DB[:conn].execute(sql, self.id).uniq
    id_nums = id_hash.map { |row_hash| row_hash.values.first }
    sql = <<-SQL
      INSERT INTO directors_genres (director_id,genre_id)
      VALUES (?, ?)
    SQL
    id_nums.each { |num| DB[:conn].execute(sql, director.id, num) }
  end

  def populate_directors_genres_from_add_genre(genre)
      dir_id = self.director_id
      if dir_id
        sql = "INSERT INTO directors_genres (director_id, genre_id) VALUES (?, ?)"
        DB[:conn].execute(sql, dir_id, genre.id)
      end
  end

  def populate_actors_directors_from_add_actor(actor)
    dir_id = self.director_id
    if dir_id
      sql = "INSERT INTO actors_directors (actor_id, director_id) VALUES (?, ?);"
      DB[:conn].execute(sql, actor.id, dir_id)
    end
  end

  def populate_actors_directors_from_add_director(director)
    sql = <<-SQL
      SELECT movies_actors.actor_id FROM movies_actors
      WHERE movies_actors.movie_id = ?
    SQL
    id_hash = DB[:conn].execute(sql, self.id).uniq
    id_nums = id_hash.map { |row_hash| row_hash.values.first }
    sql = <<-SQL
      INSERT INTO actors_directors (director_id,actor_id)
      VALUES (?, ?)
    SQL
    id_nums.each { |num| DB[:conn].execute(sql, director.id, num) }
  end

  def populate_actors_genres_from_add_actor(actor)
    sql = <<-SQL
      SELECT movies_genres.genre_id FROM movies_genres
      WHERE movies_genres.movie_id = ?
    SQL
    id_hash = DB[:conn].execute(sql, self.id).uniq
    id_nums = id_hash.map { |row_hash| row_hash.values.first }
    sql = <<-SQL
      INSERT INTO actors_genres (actor_id, genre_id)
      VALUES (?, ?)
    SQL
    id_nums.each { |num| DB[:conn].execute(sql, actor.id, num) }
  end

  def populate_actors_genres_from_add_genre(genre)
    sql = <<-SQL
      SELECT movies_actors.actor_id FROM movies_actors
      WHERE movies_actors.movie_id = ?
    SQL
    id_hash = DB[:conn].execute(sql, self.id).uniq
    id_nums = id_hash.map { |row_hash| row_hash.values.first }
    sql = <<-SQL
      INSERT INTO actors_genres (actor_id, genre_id)
      VALUES (?, ?)
    SQL
    id_nums.each { |num| DB[:conn].execute(sql, num, genre.id) }
  end
end
