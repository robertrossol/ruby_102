class Person
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end

  # def name
  #   @name
  # end

  # def name=(name)
  #   @name = name
  # end
end
puts "#1"
bob = Person.new('bob')
p bob.name # => 'bob'
bob.name = 'Robert'
p bob.name

#########################
# Modify the class definition from above to facilitate the following methods. Note that there is no name= setter method now.

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ""
  end

  def name
    # [@first_name, @last_name].join(" ").strip
    "#{@first_name} #{@last_name}".strip
  end
end

puts "#2"
bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

###################
# Now create a smart name= method that can take just a first name or a full name, and knows how to set the first_name and last_name appropriately.

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{@first_name} #{@last_name}".strip
  end

  def to_s
    name
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ""
  end
end

puts "#3"
bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'
p bob.name                  # => 'John Adams'

##################
# Using the class definition from step #3, let's create a few more people -- that is, Person objects.

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

# If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?

p bob.name == rob.name

puts "The person's name is: #{bob}"

