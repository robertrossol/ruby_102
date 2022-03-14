class MinilangError < StandardError; end
class StackError < MinilangError; end
class CommandError < MinilangError; end

class Minilang
  MUTATING_COMMANDS = %w(ADD SUB MULT DIV MOD POP)
  NON_MUTATING_COMMANDS = %w(PRINT PUSH)
  COMMANDS = MUTATING_COMMANDS + NON_MUTATING_COMMANDS

  def initialize(command_string)
    @commands = command_string
  end

#   CENTIGRADE_TO_FAHRENHEIT =
#   '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
#   Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval


  def eval(**args)
    @register = 0
    @stack = []

    @commands = format(@commands, args) if args
      # args.each do |key,|
      #   format(@commands, key : value)
      # end

    # @commands = @commands.split
    @commands.split.map do |command|
      command == command.to_i.to_s ? command.to_i : command
    end.each do |command|
      eval_command(command)
    end
    puts ""
  rescue MinilangError => e
    puts e.message
    puts ""
  end

  def eval_command(command)
    if command.is_a?(Integer)
      @register = command
    elsif COMMANDS.include?(command)
      send(command.downcase)
    else
      raise CommandError, "#{command} is not a valid command"
    end
  end

  def print
    puts @register
  end

  def push
    @stack.push(@register)
  end

# ADD Pops a value from the stack and adds it to the register value, storing the result in the register.
  def add
    @register += pop
  end
# SUB Pops a value from the stack and subtracts it from the register value, storing the result in the register.
  def sub
    @register -= pop
  end
# DIV Pops a value from the stack and divides it into the register value, storing the integer result in the register.
  def div
    @register /= pop
  end
# MOD Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
  def mod
    @register %= pop
  end
# POP Remove the topmost item from the stack and place in register
  def pop
    raise StackError, 'Stack is empty!' if @stack.empty?
    @register = @stack.pop
  end

  def mult
    @register *= pop
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
# CENTIGRADE_TO_FAHRENHEIT =
#   '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
# # 212
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
# # 32
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval
# # -40

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)
# 212
minilang.eval(degrees_c: 0)
# # 32
minilang.eval(degrees_c: -40)