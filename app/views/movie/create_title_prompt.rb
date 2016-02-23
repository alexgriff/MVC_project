class MovieCreateTitleView
    def render
      puts "what is the title of the movie you would like to create?"
      title = gets.chomp
      {title: title}
    end
end