require 'pry'
module Populate

  # Examples:
  # called on an instance of resource that is being added to a movie:
  # director.genres = populate("genres", "directors")
  # actor.directors = populate("director", "actors")
  #
  # Note that if director is the resource it is singular, not plural
  # because a Movie-object has a .director method
  def populate(resource, current_class)
    self.movies.map do |title|
      found = Movie.find_or_create_by_name(title).send(resource)
      
      if found.is_a? Array
        array_populate(found, current_class)
      elsif found
        single_elem_populate(found, current_class)
      end

    end.compact.flatten.uniq
  end

  

  def array_populate(arr, current_class)
    arr.each {|elem| elem.send(current_class) << self.name }
    arr.map { |elem| elem.name}
  end

  def single_elem_populate(elem, current_class)
    elem.send(current_class) << self.name
    elem.name
  end

end

