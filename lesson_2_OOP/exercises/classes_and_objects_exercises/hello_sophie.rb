# Using the code from the previous exercise, add a parameter to #initialize that provides a name for the Cat object. Use an instance variable to print a greeting with the provided name. (You can remove the code that displays I'm a cat!.)

# Using the code from the previous exercise, move the greeting from the #initialize method to an instance method named #greet that prints a greeting when invoked.

# Using the code from the previous exercise, add a getter method named #name and invoke it in place of @name in #greet.

module Walkable
  def walk
    puts "Lets go for a walk!"
  end
end

class Cat
  include Walkable

  attr_accessor :name
  
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new("Sophie")
kitty.greet
kitty.name = "Luna"
kitty.greet
kitty.walk