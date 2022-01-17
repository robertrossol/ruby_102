module Towable
  def initialize(year, model, color, towing_capacity, hitch)
    super(year, model, color)
    @towing_capactiy = towing_capacity
    @hitch = hitch
  end

  def can_tow?(pounds)
    pounds < towing_capacity ? true : false
  end
end

class Vehicle
  attr_accessor :color, :speed
  attr_reader :year, :model, :number_of_vehicles

  @@number_of_vehicles = 0

  def initialize(year, model, color)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@number_of_vehicles += 1
  end

  def self.vehicle_count
    puts @@number_of_vehicles
  end

  def current_speed
    "Your current speed is #{speed}mph"
  end

  def speed_up(num)
    self.speed += num
    puts "You sped up #{num}mph to #{@speed}mph"
  end

  def brake(num)
    self.speed -= num
    puts "You slowed down #{num}mph to #{@speed}mph"
  end

  def turn_off
    self.speed = 0
    puts "Putting it in park"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def self.gas_mileage(gallons, miles)
    puts "#{(miles.to_f / gallons).round(2)} per gallon of gas"
  end

  def age
    puts "Your #{self.model} is #{years_old} years old"
  end

  private

  def years_old
    Time.now.year - self.year
  end

end

class MyCar < Vehicle

  NUMBER_OF_DOORS = 4

  def to_s
    puts "My car is a #{year}, #{color}, #{@model}, going #{speed}mph."
  end
end

class MyTruck < Vehicle
  include Towable
  NUMBER_OF_DOORS = 2

  # def initialize(year, color, model, towing_capactiy, hitch)
  #   super(year, color, model)
  #   # @towing_capactiy = towing_capactiy
  #   # @hitch = hitch
  # end

  def to_s
    puts "My truck is a #{year}, #{color}, #{@model}, going #{speed}mph."
  end
end

my_car = MyCar.new(2010, 'Ford Focus', 'silver')
my_truck = MyTruck.new(2010, 'Ford Tundra', 'white', 47, true )

# puts my_car
# puts my_truck
# puts MyCar.gas_mileage(40,123)
# puts Vehicle.vehicle_count
# puts MyCar.ancestors
# puts MyTruck.ancestors
# puts Vehicle.ancestors

lumina = MyCar.new(1997, 'chevy lumina', 'white')
lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
# lumina.shut_down
MyCar.gas_mileage(13, 351)
lumina.spray_paint("red")
puts lumina
p lumina
lumina.age
# puts MyCar.ancestors
# puts MyTruck.ancestors
# puts Vehicle.ancestors

class Student
  # attr_accessor :name
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  # def results(student)
  #   puts "Well done!" if self.better_grade_than?(student)
  # end
  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end

end

joe = Student.new("joe", 85)
bob = Student.new("bob", 75)

puts "Well done!" if joe.better_grade_than?(bob)

# define a class
class Box
  attr_reader :width, :height
  # constructor method
  def initialize(w,h)
     @width, @height = w, h
  end
  # instance method
  def getArea
     @width * @height
  end

  def +(other)       # Define + to do vector addition
    Box.new(@width + other.width, @height + other.height)
  end

  def -@           # Define unary minus to negate width and height
      Box.new(-@width, -@height)
  end

  def *(scalar)           # To perform scalar multiplication
      Box.new(@width*scalar, @height*scalar)
  end

  def to_s
    "(w:#@width,h:#@height)"  # string formatting of the object.
 end
end

# define a subclass
class BigBox < Box

  # add a new instance method
  def printArea
    #  @area = @width * @height
    @area = getArea
    puts "Big box area is : #@area"
  end

  def getArea
    @area = @width * @height
    puts "Big box area is : #@area"
 end
end

# create an object
box = Box.new(10, 20)
box2 = Box.new(15, 23)
big_box = BigBox.new(10, 20)

# print the area
box.getArea()
big_box.getArea()
puts x = box + big_box

class Student
  attr_accessor :name, :grade

  def initialize(name)
    @name = name
    @grade = "X"
  end

  def change_grade(new_grade)
    @grade = new_grade
  end

end

priya = Student.new("Priya")
priya.change_grade('A')
p priya.grade
