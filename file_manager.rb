require "./string_helpers.rb"
require "./html_helpers.rb"

def file_creator(filename)
  lines = IO.readlines(filename)
  lines.each_with_index do |line, idx|
    matchdata = split_function_name(line)
    if matchdata
      lines[idx] = new_function_text(line, matchdata, randomize_function_name(matchdata))
    end
  end
  file = File.new("out.rb", "w+")
  file.write("RECORDER = []

")
  lines.each {|line| file.write(line)}
  file.close
end

def html_creator(text)
  file = File.new("index.html", "w+")
  file.write(text)
  file.close
end


# TODOs:
# 1) handle variable assignment
# 2) shell script, including directory structure
# 3) error handling
# 4) display of complex objects
# 5) javascript
# 6) asynchronous methods in javascript
# 7) interact with react
# 8) interact with rails
