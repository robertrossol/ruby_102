class Pet
  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "a #{@type} named #{@name}"
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def number_of_pets
    @pets.size
  end

  def print_pets
    puts pets
  end

  def to_s
    "#{@name}"
  end
end 

class Shelter
  def initialize(pets_array=[])
    @owners = []
    @pets = pets_array
  end
  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners << owner if !@owners.include?(owner)
    # @owners[owner.name] ||= owner
    # @owners[owner] ? @owners[owner] << pet : @owners[owner] = [pet]
  end

  def print_adoptions
    # @adoptions.each do |owner, adoptees_array|
    #   puts "#{owner} has adopted the following pets:"
    #   adoptees_array.each {|pet| puts pet }
    # end
    @owners.each do |owner|
      puts "#{owner} has adopted the following pets:"
      owner.print_pets
    end
  end
  
  def print_pets
    puts "The Animal Shelter has the following unadopted pets:"
    puts @pets
  end
  def number_of_pets
    @pets.size
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

pets = %w(dog Asta dog Laddie cat Fluffy cat Kat cat Ben parakeet Chatterbox parakeet Bluebell).each_slice(2).map {|type, name| Pet.new(type, name)}

shelter = Shelter.new(pets)
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
shelter.print_pets
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal Shelter has #{shelter.number_of_pets} unadopted pets."


# Write the classes and methods that will be necessary to make this code run, and print the following output:

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.

