module Findable

  def find_by_name(title)
    self.all.find {|elem| elem.name == title}
  end
  # already have our SQL method

  def find_or_create_by_name(title)
    find_by_name(title) || self.new(title) # + self.save ?
  end

end
