class MyCar
  attr_accessor :color, :speed
  attr_reader :year
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def to_s
    puts "My car is a #{year}, #{color}, #{@model}, going #{speed}mph."
  end

  def self.gas_mileage(gallons, miles)
    puts "#{(miles.to_f / gallons).round(2)} per gallon of gas"
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
end

honda = MyCar.new(1998, "blue", "Civic")
p honda.speed
honda.speed_up(40)
p honda.speed
honda.brake(15)
p honda.speed
honda.turn_off
p honda.current_speed
p honda.color
honda.spray_paint("yellow")
p honda.color
MyCar.gas_mileage(15, 425)
p honda
puts honda