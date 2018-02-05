require_relative "./scope.rb"

class EnvStack
  LETTERS = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a + ["_", "."]
  def initialize(parsed)
    @parsed = parsed
    @env = []
    @scope_stack = []
    @method_body = false
  end

  attr_reader :parsed, :scope_stack, :env
  attr_accessor :method_body

  # #{, }, {, |, ), ", '
  def handle_other
  end

  def handle_word
    unless currently_in_string
      word = parsed.last
      if ["if", "while", "until", "unless"].include?(word)
        env.push(word)
      elsif ["def", "do"].include?(word)
        scope_start(word)
      elsif "end" == word
        scope_end(word)
      end
    end
  end

  def new_word
    current_scope.add_variable(parsed.length-1) if argument_block
    current_scope.add_word(parsed.length-1) if method_body
  end



  def add_variable
    i = parsed.length-1
    until LETTERS.include?(parsed[i][0])
      i = i-1
    end
    current_scope.add_variable(i)
  end

  def current_scope
    scope_stack.last
  end

  def argument_block
    env.last == "def" || env.last = "\|"
  end

  def currently_in_string
    env.last == "\'" || env.last == "\""
  end

end
