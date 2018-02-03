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


# def file_creator(filename)
#   file = File.new("out", "w+")
#   file.write("testing...")
#   file.close
# end
