class AssociateDirectorPromptView
    def render
        puts "Do you want to associate this director to a movie? (y/n)"
        input = gets.chomp.downcase
    end
end