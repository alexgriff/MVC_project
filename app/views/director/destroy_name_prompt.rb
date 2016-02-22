class DirectorDestroyNameView
    def render
        puts "what is the name of the director you want to erase from the database and disassociate from all movies?"
        name = gets.chomp
    end
end