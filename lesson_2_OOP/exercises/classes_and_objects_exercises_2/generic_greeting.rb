# Modify the following code so that Hello! I'm a cat! is printed when Cat.generic_greeting is invoked.

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting
kitty = Cat.new
kitty.class.generic_greeting

#part 2
# Using the following code, add two methods: ::generic_greeting and #personal_greeting. The first method should be a class method and print a greeting that's generic to the class. The second method should be an instance method and print a greeting that's custom to the object.

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

  def personal_greeting
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting


# Hello! I'm a cat!
# Hello! My name is Sophie!