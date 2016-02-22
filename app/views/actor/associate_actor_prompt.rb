class AssociateActorPromptView
    def render
        puts "Do you want to associate this actor to a movie? (y/n)"
        input = gets.chomp.downcase
    end
end