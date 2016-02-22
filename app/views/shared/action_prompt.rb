class ActionView
    def render
      puts "what action would you like to take: add, show, destroy, index"
      action = gets.chomp
    end
end