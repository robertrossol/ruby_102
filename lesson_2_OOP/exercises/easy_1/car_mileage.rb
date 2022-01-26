class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total #in the original line (mileage = total) mileage is referencing a local variable instead of the setter method
    #@mileage = total works too but bypasses the setter method, which is dangerous since ther could be other safety checks or behavior in the setter method
  end

  def print_mileage
    puts @mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678