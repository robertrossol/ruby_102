# Modify this class so both flip_switch and the setter method switch= are private methods.

class Machine
  # attr_reader :switch

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def switch_position
    switch
  end

  private

  attr_accessor :switch

  # def switch=(desired_state)
  #   @switch = desired_state
  # end

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

robot = Machine.new
robot.start
puts robot.switch_position
robot.stop
puts robot.switch_position