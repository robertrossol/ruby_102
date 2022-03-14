class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100

  def initialize(low_bound, high_bound)
    @range = low_bound..high_bound
    @winning_number = nil
  end

  def guess
    puts "enter a number betweeen #{@range.first} and #{@range.last}:"
    pick = nil
    loop do
      pick = gets.chomp.to_i
      break if @range.cover?(pick)
      puts "Invalid guess. Enter a number betweeen #{@range.first} and #{@range.last}:"
    end
    pick
  end

  def evaluate_guess(guess)
    if guess < @winning_number
      puts "Your guess is too low"
    elsif guess > @winning_number
      puts "Your guess is too high"
    else
      puts "That's the Number!"
      puts "You Win!"
      @won = true
    end
  end


  def play
    @winning_number = rand(@range)
    @guesses = Math.log2(@range.last - @range.first).to_i + 1
    @won = false
    # initialize
    while @guesses > 0 && !@won
      puts "You have #{@guesses} guesses remaining."
      evaluate_guess(guess)
      @guesses -= 1
    end
    puts "You have no more guesses. You lost!" if !@won 
  end
end

game = GuessingGame.new(200, 500)
game.play
game.play


# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.