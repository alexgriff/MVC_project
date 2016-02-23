class GenreCreateNameView
    def render
        puts "what is the name of the genre you would like to create?"
        name = gets.chomp
        {name: name}
    end
end