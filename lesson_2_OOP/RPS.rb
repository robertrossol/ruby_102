class Score
  attr_accessor :value, :winner

  @@winning_total = 5

  def initialize
    @value = 0
    @winner = nil
  end

  def self.winning_total
    @@winning_total
  end

  def self.winning_total=(value)
    @@winning_total = value
  end

  def increment
    @value += 1
    @winner = true if @value == @@winning_total
  end

  def to_s
    @value.to_s
  end

  # def display
  #   puts "**** Scoreboard ****"
  #   puts "* #{@player_1.name}: #{@player_1.score}".ljust(19) + "*"
  #   puts "* #{@player_2.name}: #{@player_2.score}".ljust(19) + "*"
  #   puts "*" * 20
  # end
end

class Move
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = Score.new
  end

  # def update_score
  #   @score += 1
  # end
end

class Human < Player
  def set_name
    name = ""
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, must enter a value."
    end
    self.name = name
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
    @winner = nil
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def determine_winning_score
    puts "how many points would you like to play to?"
    points = gets.chomp.to_i
    points = 5 if points == 0
    puts "Playing to #{points} points"
    Score.winning_total = points
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      human.score.increment
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      computer.score.increment
    else
      puts "It's a tie!"
    end
  end

  def winner?
    if human.score.winner || computer.score.winner
      @winner = human.score.winner ? human : computer
    end
  end

  def display_score
    puts "**** Scoreboard ****"
    puts "* #{human.name}: #{human.score}".ljust(19) + "*"
    puts "* #{computer.name}: #{computer.score}".ljust(19) + "*"
    puts "*" * 20
  end

  def play_again?
    answer = nil
    loop do
      puts "would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def play
    display_welcome_message
    determine_winning_score
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      display_score
      break if winner? || !play_again?
    end
    if winner?
      puts "#{@winner.name} Wins!"
    end
    display_goodbye_message
  end
end

RPSGame.new.play
