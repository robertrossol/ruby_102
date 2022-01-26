# Complete this class so that the test cases shown below work as intended. You are free to add any methods or instance variables you need. However, do not make the implementation details public.

class Banner
  def initialize(message, length=message.size+2)
    @message = message
    @length = length < (message.size + 2) ? message.size + 2 : length
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+" + ("-" * @length) + "+"
  end

  def empty_line
    "|" + (" " * @length) + "|"
  end

  def message_line
    extra_empty_space = " " * (@length - (@message.size + 2))
    "|" + " #{@message} " + extra_empty_space + "|"
  end
end

#Test Cases

banner = Banner.new('To boldly go where no one has gone before.', 45)
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('', -5)
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+