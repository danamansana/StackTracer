# This file contains helper methods for string manipulation that occurs in the StackTrace

#The first method should take a string and return either false if the string is not of form def...
#or match data with the def part and the non-def part if it is

def split_function_name(line)
   /(\s*def\s*)(\S[^\(]*)(\(.*)/.match(line)
end

#this function splices a random id before the name of the new function
def randomize_function_name(matchdata)
  id = [*('A'..'Z')].sample(8).join
  "#{id}#{matchdata[2]}"
end



#this function returns the text of the new function

def new_function_text(line, matchdata, randomized_name)
  "#{line}
    record = {}
    method(__method__).parameters.each{|arg| record[arg[1].to_s] = (eval arg[1].to_s)}
    RECORDER.push([\"#{matchdata[2]}\", record, \"called\"])
    x = #{randomized_name}(*(record.values))
    RECORDER.push([\"#{matchdata[2]}\", x, \"returned\"])
    return x
end

#{matchdata[1]}#{randomized_name}#{matchdata[3]}
  "
end
