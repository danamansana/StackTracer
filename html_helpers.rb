#parse_hash converts a hash into a string
def parse_hash(hash)
  hash.keys.map{|key| "#{key} = #{hash[key]}"}.join(",")
end
# opener generates the HTML for a function call
def opener(record_entry, num)
  "<div class=\"flag\">
  <div class=\"flag-side\"></div>
  <div class=\"main\">
    <div class=\"opener\">
      #{record_entry[0]} called with #{parse_hash(record_entry[1])}
    </div>
    <div class=\"button-holder\">
    <div class=\"first-button\" onclick=\"toggleChildren(#{num})\">Display Details</div>
    <div class=\"second-button\" onclick=\"toggleDescendents(#{num})\">Display All Details</div>
    </div>
    <div class=\"hide\" id=\"#{num}\">
    "
end

#closer generates the HTML when a function returns
def closer(record_entry)
  " </div>
    <div class=\"closer\">
      #{record_entry[0]} returned with #{record_entry[1]}
    </div>
  </div>
  </div>
  "
end


#main_text generates the variable part of the html from a record by iterating through entries and calling opener and closer
def main_text(record)
  text = ""
  record.each_with_index do |record_entry, idx|
    if record_entry[2] == "called"
      text += opener(record_entry, idx)
    else
      text += closer(record_entry)
    end
  end
  text
end

#generate_html calls main_text and interpolates into the static part of the HTML. This is the main method that generates the display.
def generate_html(record)
  "<!DOCTYPE html>
  <html>
    <head>
      <meta charset=\"utf-8\">
      <link rel=\"stylesheet\" href=\"./style.css\" />
      <script type=\"application/javascript\" src=\"./click_handlers.js\"></script>
      <title></title>
    </head>
    <body>
      #{main_text(record)}
    </body>
  </html>"
end
