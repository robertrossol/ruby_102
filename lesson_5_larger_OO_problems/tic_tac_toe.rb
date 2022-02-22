# In this assignment, we'll build a Tic Tac Toe game, just like the one we built before. This game is a little bit more complicated than Rock, Paper, Scissors, because there's the notion of a "game state", which should represent the current state of the board (the RPS game didn't have game state, only choices).
# 1. Write a description of the problem and extract major nouns and verbs.
# - Tic Tac Toe is a two player game, played on a 3x3 board, where players take turns placing their marker (X or O) in open spaces on the board, attempting to get three in a row. If the board fills up and noone achieves three in a row the game ends in a tie.
# 2. Make an initial guess at organizing the verbs into nouns and do a spike to explore the problem with temporary code.
# - Nouns: player, board, marker, space
#     (board, player, square, grid)
#   Verbs: check board (check for 3 in a row), place
#     (play, mark)
# Board
# Square
# Player
# - mark
# - play
require 'pry'
class Board
  WINNING_COMBINATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                          [1, 4, 7], [2, 5, 8], [3, 6, 9],
                          [1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def empty_square_keys
    @squares.select { |_, square| square.empty? }.keys
  end

  def full?
    empty_square_keys.empty?
  end

  def at_risk_squares(marker)
    WINNING_COMBINATIONS.each_with_object([]) do |line, arr|
      markers = @squares.values_at(*line).map(&:marker)
      if markers - [marker] == [Square::INITIAL_MARKER]
        arr << line[markers.index(Square::INITIAL_MARKER)]
      end
      return arr if !arr.empty?
    end
  end

  def winning_marker
    WINNING_COMBINATIONS.each do |line|
      # squares = line.map { |num| @squares[num] }
      squares = @squares.values_at(*line)
      if three_identical_markers(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def someone_won?
    !!winning_marker
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def reset
    (1..9).each { |num| @squares[num] = Square.new }
  end

  private

  def three_identical_markers(squares)
    markers = squares.select(&:marked?).map(&:marker)
    return false if markers.size != 3
    # squares.uniq.count == 1
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def empty?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def to_s
    @marker
  end
end

class Player
  attr_accessor :marker, :score, :name

  @@Player_count = 0

  def initialize(marker)
    @@Player_count += 1
    @marker = marker
    @name = "player #{@@Player_count}"
    @score = 0
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = HUMAN_MARKER
  WINNING_SCORE = 5
  attr_reader :board, :human, :computer
  attr_accessor :human_turn

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = HUMAN_MARKER
  end

  def play
    clear
    display_welcome_message
    choose_marker
    enter_name
    main_game
    display_match_results if match_over?
    display_goodbye_message
  end

  private

  def choose_marker
    puts "Plese enter a single character marker (only first char will be used)"
    human.marker = gets.chomp[0]
  end

  def enter_name
    puts "Please enter your name"
    human.name = gets.chomp || human.name
    computer.name = ['HAL', 'Fi', 'Google'].sample
  end

  def display_scoreboard
    puts "Scoreboard:"
    puts "#{human.name}'s Wins: #{human.score}"
    puts "#{computer.name}'s Wins: #{computer.score}"
  end

  def match_winner
    [human, computer].max { |a, b| a.score <=> b.score }
  end

  def display_match_results
    if match_winner == human
      puts "#{human.name} Won the Match!"
    else
      puts "#{computer.name} Won the Match"
    end
  end

  def match_over?
    human.score >= WINNING_SCORE || computer.score >= WINNING_SCORE
  end

  def main_game
    loop do
      display_board
      player_move
      display_result
      display_scoreboard
      break unless !match_over? && play_again?
      reset
      display_play_again_message
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def clear
    system 'clear'
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
    puts ""
  end

  def display_board
    puts "#{human.name} is #{human.marker}'s, #{computer.name} is #{computer.marker}'s"
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def joinor(arr, delimiter = ', ', conjunction = 'or')
    case arr.size
    when 1
      arr[0]
    when 2
      arr.join(" #{conjunction} ")
    else
      arr[-1] = "#{conjunction} #{arr.last}"
      #[arr[0..-2].join(delimiter), arr[-1]].join("#{delimiter}#{conjunction} ")
      arr.join(delimiter)
    end
  end

  def human_moves
    puts "Choose an available square: #{joinor(board.empty_square_keys)}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.empty_square_keys.include?(square)
      puts "sorry, that's not a valid choice."
    end

    board[square] = human.marker
    # board.[]=(square, human.marker)
  end

  def computer_moves
    num = (board.at_risk_squares(computer.marker).first ||
          board.at_risk_squares(human.marker).first) ||
          (5 if board.empty_square_keys.include?(5)) ||
          board.empty_square_keys.sample
    # num = (board.at_risk_squares(computer.marker).first || board.at_risk_squares(human.marker).first))
    # num = 5 if !num && board.empty_square_keys.include?(5)
    # num = board.empty_square_keys.sample if !num
    board[num] = computer.marker
  end

  def current_player_moves
    if @current_marker == HUMAN_MARKER
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
      clear_screen_and_display_board
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      puts "You Won!"
      human.score += 1
    when computer.marker
      puts "#{computer.name} Won!"
      computer.score += 1
    else
      puts "It's a Tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Must choose y or n"
    end
    answer == 'y'
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play
