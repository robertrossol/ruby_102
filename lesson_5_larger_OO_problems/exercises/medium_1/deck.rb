require_relative 'cards.rb'

class Deck
  attr_accessor :cards
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    # @cards = SUITS.map do |suit|
    #           RANKS.map do |rank|
    #             Card.new(rank, suit)
    #           end
    # end.flatten.shuffle
    # @cards = RANKS.product(SUITS).map{ |rank, suit| Card.new(rank, suit) }.shuffle
    reset
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.product(SUITS).map{ |rank, suit| Card.new(rank, suit) }
    @deck.shuffle!
  end
end

# deck = Deck.new
# drawn = []
# 52.times { drawn << deck.draw }
# # p drawn
# p drawn.count { |card| card.rank == 5 } == 4
# p drawn.count { |card| card.suit == 'Hearts' } == 13

# drawn2 = []
# 52.times { drawn2 << deck.draw }
# p drawn != drawn2 # Almost always.

# deck = Deck.new
# p deck.cards.count { |card| card.rank == 5 } == 4
# p deck.cards.count { |card| card.suit == 'Hearts' } == 13
# puts deck.draw
# puts deck.cards.size

# cards = [Card.new(2, 'Hearts'),
#   Card.new(10, 'Diamonds'),
#   Card.new('Ace', 'Clubs')]
# puts cards
# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')