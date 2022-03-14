require_relative 'deck.rb'

# Include Card and Deck classes from the last two exercises.

class PokerHand
  OPTIONS = ["hI"]
  attr_reader :ranks, :suits

  def initialize(deck)
    @hand = []
    5.times do
      @hand << deck.draw
    end
    @ranks = @hand.sort.map(&:rank)
    @suits = @hand.map(&:suit)
  end

  def print
    puts @hand
    # @hand.each do |card|
    #   puts card
    # end
  end

  def to_s
    puts @hand
  end

  def self.to_s
    self::OPTIONS
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    # flush? && ranks == Card::RANKS[-5..-1]
    straight_flush? && ranks.first == 10
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    x = ranks.select{|value| ranks.count(value) > 1}
    x.size == 4 && x.uniq.size == 1
  end

  def full_house?
    ranks.select{|value| ranks.count(value) > 1}.size == 5
  end

  def flush?
    suits.uniq.size == 1
  end

  def straight?
    # p ranks
    # p Card::RANKS[Card::RANKS.index(ranks.first)..(Card::RANKS.index(ranks.first)+4)]
    # ranks == Card::RANKS[Card::RANKS.index(ranks.first)..Card::RANKS.index(ranks.last)]
    Card::RANKS.index(ranks.last) - Card::RANKS.index(ranks.first) == 4 && ranks.uniq.size == 5
  end

  def three_of_a_kind?
    # ranks = @hand.map(&:rank)
    ranks.select{|value| ranks.count(value) > 1}.size == 3
  end

  def two_pair?
    # ranks = @hand.map(&:rank)
    ranks.select{|value| ranks.count(value) > 1}.uniq.size == 2
  end

  def pair?
    ranks.uniq.size < 5
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
# puts hand
puts PokerHand.to_s
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate #== 'Straight flush'
puts PokerHand.to_s

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'