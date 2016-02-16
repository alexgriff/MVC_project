module Findable


def find_by_name(title)
  self.all.find {|elem| elem.name == title}
end

def find_or_create_by_name(title)
  find_by_name(title) || self.new(title)
end

end
