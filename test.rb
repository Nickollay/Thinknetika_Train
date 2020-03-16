def input
  @input = gets.chomp.downcase
end

def input_menu_valid
  input
  if (/[1-3]/.match?(input).! && input != 'stop')
end

input_menu_valid
puts @input