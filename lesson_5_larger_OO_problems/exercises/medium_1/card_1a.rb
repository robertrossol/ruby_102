# Update this class so you can use it to determine the lowest ranking and highest ranking cards in an Array of Card objects:

class Card
  include Comparable
  attr_reader :rank, :suit
  
  RANKS = %w(2 3 4 5 6 7 8 9 10).map!(&:to_i) + %w(Jack Queen King Ace)
  SUITS = %w(Diamonds Clubs Hearts Spades)
  # RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other_card)
    if rank == other_card.rank
      SUITS.index(suit) <=> SUITS.index(other_card.suit)
    else
      RANKS.index(rank) <=> RANKS.index(other_card.rank)
    end
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

cards = [Card.new(2, 'Hearts'),
  Card.new(10, 'Diamonds'),
  Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
  Card.new(4, 'Diamonds'),
  Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
  Card.new('Jack', 'Diamonds'),
  Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Clubs'),
  Card.new(8, 'Diamonds'),
  Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8
puts cards.max == Card.new(8, 'Spades')
puts cards.min == Card.new(8, 'Diamonds')
