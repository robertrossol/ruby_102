# rubocop:disable all
# - Twenty One is a card game with a Dealer and Players (one player in our case). It uses a standard 52-card deck with 4 suits and 13 values (2,3,4,5,6,7,8,9,10,J,Q,K,A). The goal is for players to accumulate cards that add up to 21 (or as close as possible), without going over (busting). If they end with closer to 21 than the dealer, or the dealer busts, they win. 
#   -Players are dealt two cards face up, Dealer is dealt one card face up and one face down
#   -Players choose to hit (get another card) or stay
#     -If players hit and go over 21, they bust and lose
#   -Once Player stays, Dealer reveals second card and then hits until they have at least 17 (or bust)
#   -Special Rule:
#     -All number cards are equal to their number value.
#     -The 10 and Face cards are worth 10
#     -Aces are worth 11 or 1, whichever gets the hand closest to 21 (without busting)
#       -Aces are revaluated on each hit. 
# - NOUNS:
#   - Player, Dealer, Card, Deck, Game, Total, participant
# -VERBS:
#   - Deal, Hit, Stay, Bust
# -CLASSES:
#   - Player
#     - hit
#     - stay
#     - busted?
#     - total
#   - Dealer
#     - hit
#     - stay
#     - busted?
#     - total
#     - deal (Q: should the be here or in Deck? A: In Deck)
#   - Participant (Super class to hold shared functionality between dealer and player)
#   - Deck
#     - deal
#   - Card
#   - Game
#     - start
# we use a Hand module that is mixed into Player and Dealer, but you don't have to do that
# rubocop:enable all
require 'pry'

module Hand
  def show_hand
    puts "---- #{name}'s Hand ----"
    puts cards.join(", ")
    puts "Total: #{total}"
  end

  def correct_for_aces
    return unless total > 21 && aces.count > 0
    aces.each do |ace|
      ace.value = 1
      total <= 21 ? break : next
    end
  end
end

class Participant
  include Hand

  attr_accessor :cards, :name

  def initialize
    @cards = []
    @name = set_name
  end

  def add_card(card)
    cards << card
  end

  def busted?
    total > 21
  end

  def aces
    cards.select { |card| card.name[0] == "A" }
  end

  def total
    cards.map(&:value).reduce(:+)
  end
end

class Player < Participant
  def set_name
    name = ''
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, must enter a value."
    end
    self.name = name
  end
end

class Dealer < Participant
  ROBOTS = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']

  def set_name
    self.name = ROBOTS.sample
  end
end

class Deck
  attr_reader :cards

  def initialize
    suits = %w(H D C S)
    names = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    values = (2..10).to_a + [10, 10, 10, 11]
    @cards = suits.map do |suit|
               names.map do |name|
                 "#{name}#{suit}"
               end
             end.flatten.map.with_index do |card, index|
               Card.new(card, values[index % 13])
             end.shuffle!
  end

  def to_s
    cards
  end

  def deal_card
    cards.pop
  end

  def aces
    cards.select { |card| card.value == 11 }
  end
end

class Card
  attr_reader :name
  attr_accessor :value

  def initialize(name, value)
    @name = name
    @value = value
  end

  def to_s
    name
  end
end

class Game
  attr_accessor :deck, :dealer, :player

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
  end

  def deal_cards
    [player, dealer].each do |participant|
      2.times { participant.add_card(deck.deal_card) }
      participant.correct_for_aces
    end
  end

  def show_initial_cards
    puts "---- #{dealer.name}'s Hand ----"
    puts dealer.cards.first
    player.show_hand
  end

  def player_turn
    loop do
      break if player.busted? || player_choice == "s"
      player.add_card(deck.deal_card)
      player.correct_for_aces
      player.show_hand
    end
  end

  def player_choice
    puts "hit(h) or stay(s)?"
    choice = ""
    loop do
      choice = gets.chomp.downcase[0]
      break if ['h', 's'].include?(choice)
      puts "Invalid entry. Please enter 'h' for Hit or 's' for Stay"
    end
    choice
  end

  def dealer_turn
    while dealer.total < 17
      dealer.add_card(deck.deal_card)
      dealer.correct_for_aces
    end
    puts "Dealer Stays" if !dealer.busted?
  end

  def show_busted
    if player.busted?
      puts "It looks like you busted! #{dealer.name} wins!"
    elsif dealer.busted?
      puts "It looks like #{dealer.name} busted! You win!"
    end
  end

  def show_result
    puts dealer.show_hand
    puts player.show_hand

    puts winner
  end

  def winner
    if player.busted? || (player.total < dealer.total && !dealer.busted?)
      "Dealer Won!"
    elsif dealer.busted? || player.total > dealer.total
      "You Won!"
    else
      "You Tied"
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
    # initialize
    self.deck = Deck.new
    player.cards.clear
    dealer.cards.clear
  end

  def start
    loop do
      deal_cards
      show_initial_cards
      player_turn
      if player.busted?
        show_busted
        break unless play_again?
        reset
        next
      end
      dealer_turn
      if dealer.busted?
        show_busted
        break unless play_again?
        reset
        next
      end
      show_result

      play_again? ? reset : break
    end
    puts "Thank you for playing Twenty-One. Goodbye!"
  end
end

# Game.new.start

game = Game.new
game.start

# p game.player
# p game.deck.cards.pop
# p game.deck.cards.size
