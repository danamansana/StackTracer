require 'set'

class AssignmentParser
  CHARACTERS = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a + ["_", "."]
  DELIMITERS = ["\"", "\'", "\{", "\}"]
  OPENERS = ["\'", "\"", "\{"]
  CLOSERS = {"\'" => "\'", "\"" => "\"", "\}" => "\{"}
  SCOPENERS = ["def", "do", "\{"]
  CONTROL_OPENERS = ["while", "until", "if", "unless"]
  SCOPENDERS = ["\}", "end"]

  def initialize(text)
    @text = text
    @variables = Set.new
    @parsed = [""]
    @potential_assignments = []
    @words = []
    @delimiter_stack = []
    @ignore_words = Set.new
    @currently_on_word = false
    @scope_count = 0
    @control_stack  = []
    @scopenings = []
    @scope_stack = []
  end

  attr_reader :text, :variables, :parsed, :potential_assignments, :words, :delimiter_stack, :ignore_words, :control_stack, :scope_stack, :scopenings
  attr_accessor :currently_on_word, :scope_count

  def parse
    i = 0
    while i < text.length
      current = text[i]
      if current == "=" && text[i+1] != "=" && !["="].include?(text[i-1])
        handle_equals
      elsif DELIMITERS.include?(current)
        handle_delimiter(current)
      elsif CHARACTERS.include?(current)
        handle_character(current)
      else
        handle_other(current)
      end
      i +=1
    end
  end

  def handle_other(other)
    self.currently_on_word = false
    parsed.push(other)
  end

  def handle_equals
    self.currently_on_word = false
    parsed.push("=")
    potential_assignments.push(parsed.length-1)
  end

  def handle_character(character)
    if currently_on_word
      parsed[parsed.length-1] += character
    else
      parsed.push(character)
      self.currently_on_word = true
      words.push(parsed.length-1) unless ["\'", "\""].include?(delimiter_stack.last)
    end
  end

  def handle_delimiter(delimiter)
    self.currently_on_word = false
    parsed.push(delimiter)
    unless escaped?(delimiter)
      if CLOSERS[delimiter] == delimiter_stack.last
        delimiter_stack.pop
      else
        delimiter_stack.push(delimiter) unless delimiter == "\{"
        delimiter_stack.push(delimiter) if delimiter == "\{" && parsed.last == "#"
      end
      words.push(parsed.length-1) if delimiter == "\{" || delimiter == "\}"
    end
  end

  def escaped?(delimiter)
    count = 0
    i = parsed.length-1
    i = i-1 if delimiter == "\{" && parsed[i] == "#"
    until parsed[i] != "\\"
      count +=1
      i = i-1
    end
    return count%2 == 1
  end

  def populate_variables
    potential_assignments.each {|idx| add_variable(idx)}
  end

  def add_variable(i)
    current = i-1
    until CHARACTERS.include?(parsed[current][0])
      current = current-1
    end
    potential_variable = parsed[current]
    variables.add(potential_variable) unless potential_variable.include?(".")
  end

  #need to change this to ignore variables that occur in argument lists of methods or blocks

  def modify_words
    words.each do |word_idx|
      word  = parsed[word_idx]
      if SCOPENERS.include?(word) || SCOPENDERS.include?(word)
        modify_scope(word, word_idx)
      elsif CONTROL_OPENERS.include?(word)
        modify_control(word)
      else
        parsed[word_idx] = modify_word(word)
      end
    end
  end

  def modify_scope(word, idx)
    if SCOPENERS.include?(word)
      self.scope_count +=1
      control_stack.push(word)
      self.scope_stack.push(scope_count)
      scopenings.push(idx) if word == "def" || word == "do"
    else
      popped = control_stack.pop
      self.scope_stack.pop if SCOPENERS.include?(popped)
    end
  end

  def modify_control(word)
    control_stack.push(word)
  end

  def modify_word(word)
    word.split(".").map {|frag| append(frag)}.join(".")
  end

  def append(frag)
    if variables.include?(frag)
      return "proxies[#{self.scope_stack.last}].#{frag}"
    else
      return frag
    end
  end

  def modified_text
    self.parse
    self.populate_variables
    self.modify_words
    self.parsed.join("")
  end

end
