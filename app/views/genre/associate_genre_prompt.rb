class AssociateGenrePromptView
    def render
        puts "Do you want to associate this genre to a movie? (y/n)"
        input = gets.chomp.downcase
    end
end