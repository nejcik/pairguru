class TitleBracketsValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    special = "()[]}{)({}"
    regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/ # to find any of those
    if value =~ regex  # if ANY of those are in this string 
      basic_open_bracket = (0 ... value.length).find_all { |i| value[i,1] == '(' }
      basic_close_bracket = (0 ... value.length).find_all { |i| value[i,1] == ')' }
      square_open_bracket = (0 ... value.length).find_all { |i| value[i,1] == '[' }
      square_close_bracket = (0 ... value.length).find_all { |i| value[i,1] == ']' }
      curly_open_bracket = (0 ... value.length).find_all { |i| value[i,1] == '{' }
      curly_close_bracket = (0 ... value.length).find_all { |i| value[i,1] == '}' }

      # if the length of compared array bracket is not fine -> there is not enough brackets! 
      if basic_open_bracket.length != basic_close_bracket.length || square_open_bracket.length != square_close_bracket.length || curly_open_bracket.length != curly_close_bracket.length
        record.errors.add attribute, (options[:message] || "Not enough brackets (opened & not closed or closed without opening)")
      end
      
      # check if the order is OK
    end
    # has no special char => title is fine
  end
  
end