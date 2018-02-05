require_relative "./env_stack.rb"

class AssignmentParser
  LETTERS = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a + ["_", "."]
  def initialize(text)
    @text = text
    @parsed = [""]
    @env_stack = EnvStack.new(@parsed)
    @currently_on_word = false
  end

  attr_reader :text, :parsed, :env_stack
  attr_accessor :currently_on_word

  def parse
    i = 0
    while i < text.length
      handle_character(i)
    end
  end

  def handle_character(i)
    current = text[i]
    if current == "=" && text[i+1] != "="
      handle_equals
    elsif LETTERS.include?(current)
      handle_letter(current)
    else
      handle_other(current)
    end
  end

  def handle_equals
    self.currently_on_word = false
    parsed.push("=")
    env_stack.add_variable
  end

  def handle_letter(current)
    if currently_on_word
      parsed[parsed.length-1] += current
      env_stack.handle_word
    else
      parsed.push(current)
      self.currently_on_word = true
      env_stack.new_word
    end
  end

  def handle_other(current)
    parsed.push(current)
    self.currently_on_word = false
    env_stack.handle_other
  end

end
