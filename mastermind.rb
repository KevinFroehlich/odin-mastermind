class Game
  attr_accessor :colors, :code

  def initialize
    self.choose_gametype
  end

  
private
def choose_gametype
    print "Type 'human' if you want to solve the code, or 'ai' if you want to create the code and have an AI opponent solve it: "
    type = gets.chomp
    if type == "ai"
        self.ai_game
    elsif type == "human"
        self.player_game
    end
end

def ai_game
    @guess = Array.new(4, nil)
    @tries = 4
    @colors = %w[blue red yellow purple green orange]
    @code = []
    @found_balls = Array.new(4, 'hidden')
    @found_colors = []
    self.enter_code

    until self.win? || self.loss?
        self.create_ai_guess
        @tries -= 1

        4.times do |index|
          if @guess[index] == @code[index]
            puts "#{@guess[index].capitalize} at position #{index + 1} is correct."
            @found_balls[index] = @guess[index]
            @found_colors.push(@guess[index])
          end
        end
    
  
        4.times do |index|
          if @guess[index] != @code[index] && @code.include?(@guess[index]) && @code.count(@guess[index]) > @found_balls.count(@guess[index])
            puts "#{@guess[index].capitalize} at position #{index + 1} has the correct color but is at the wrong place."
            @found_colors.push(@guess[index])
          elsif @guess[index] != @code[index]
            puts "#{@guess[index].capitalize} at position #{index + 1} is incorrect and the color doesn't appear in the code."
          end
        end


  end

  if self.win?
    puts 'The AI solved your code. You LOSE!'
  else
    puts "The AI couldn't solve your code, you WIN!"
  end
end

def player_game
    @guess = []
    @tries = 4
    @colors = %w[blue red yellow purple green orange]
    @code = []
    4.times do |index|
      @code.push(@colors.sample)
    end

    puts @code
    found_balls = Array.new(4, 'hidden')
    found_colors = []
    until win? || loss?
      enter_guess
      @tries -= 1
      4.times do |index|
        if @guess[index] == @code[index]
          puts "#{@guess[index].capitalize} at position #{index + 1} is correct."
          found_balls[index] = @guess[index]
        end
      end

      4.times do |index|
        if @guess[index] != @code[index] && @code.include?(@guess[index]) && @code.count(@guess[index]) > found_balls.count(@guess[index])
          puts "#{@guess[index].capitalize} at position #{index + 1} has the correct color but is at the wrong place."
          found_colors.push(@guess[index])
        elsif @guess[index] != @code[index]
          puts "#{@guess[index].capitalize} at position #{index + 1} is incorrect and the color doesn't appear in the code."
        end
      end

      puts 'This is your code:'
      puts found_balls
    end

    if self.win?
      puts 'Congratulations, you solved the code! :)'
    else
      puts 'You failed to solve the code. :('
    end
end

  def win?
    @code == @guess
  end

  def loss?
    @tries == 0
  end

  def enter_guess
    4.times do |index|
      loop do
        print "Enter the color of your ball at position #{index + 1}: "
        @guess[index] = gets.chomp.downcase
        break if @colors.include?(@guess[index])

        puts 'Wrong color input.'
      end
    end
  end

  def enter_code
    4.times do |index|
        loop do
          print "Enter the color of your ball at position #{index + 1}: "
          @code[index] = gets.chomp.downcase
          break if @colors.include?(@code[index])
  
          puts 'Wrong color input.'
        end
    end
  end

  def create_ai_guess
    @guess = Array.new(4, nil)
    4.times do |index|
        
        if @found_balls[index] == "hidden"
            @guess[index] = @colors.sample
        elsif @found_balls[index] != "hidden"
            @guess[index] = @found_balls[index]
        end
    end
    puts "This is what the AI guessed: "
    puts @guess
  end
end

game1 = Game.new
