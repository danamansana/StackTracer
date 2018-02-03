require 'set'
require_relative './proxy_holder.rb'

class AssignmentParser

  def initialize(text)
    @text = text
    @words = [""]
    @characters = (a..z).to_a + (0..9).to_a + (A..Z).to_a + ["_", "."]
    @delimiter_stack = []
    @assignment_positions = []
    @variable_positions = []
    @variables = Set.new
    @method_calls = []
    @variable_ignore = Set.new
  end


#The next suite of functions finds variable assignments and replaces the corresponding variables with appropriate proxies.
#The first method splits up the text into chunks that include the variables

  def variable_split
    text = @text
    currently_on_word = false
    i = 0
    while i < text.length
      current = text[i]
      delimited = @delimiter_stack.last
      if @characters.include?(current)
        if currently_on_word
          @words.last += current
        else
          currently_on_word = true
          @words.push(current)
        end
      else
        handle_assignment(i)
        handle_delimiter(i)
        currently_on_word = false
        @words.push(current)
      end
      if delimited == "\'" || delimited == "\""
        @variable_ignore.add(@words.length-1)
      end
      i += 1
    end
    record_variables
  end

# records places where an assigment may be occuring
  def handle_assignment(i)
    @assignment_positions.push(i) if @text[i] == "=" && @text[i+1] != "="
  end

#handle_delimiter adds to the delimiter stack appropriately and returns true if it just handled a delimiter
  def handle_delimiter(i)
    text = @text
    current = text[i]
    if text[i-1] == "\\"
      return false
    end
    if current == "\"" || current == "\'"
      if @delimiter_stack.last == current
        @delimiter_stack.pop
      else
        @delimiter_stack.push(current)
      end
      return true
    end
    if current == "\{"
      if text[i-1] == "#" && text[i-2] != "\\"
        @delimiter_stack.push(current)
      end
      return true
    end
    if current == "\}"
      if @delimiter_stack.last == "\{"
        @delimiter_stack.push(current)
      end
      return true
    end
    return false
  end

def record_variables
  @assignment_positions.each{|pos| record_variable(pos)}
end

def record_variable(pos)
  i = pos
  while true
    if /\s/.match(@text[i])
      i = i-1
    elsif @text[i].include?(".")
      @method_calls.push(i)
      return nil
    else
      @variables_positions.push(i)
      @variables.add(@text[i])
      return nil
    end
  end
end
