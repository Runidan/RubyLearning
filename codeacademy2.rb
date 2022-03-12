print "What is your name? "
first_name = gets.chomp
first_name.capitalize!
puts "Your first name is #{first_name}"

print "what is your last name? "
last_name = gets.chomp
last_name.capitalize!
puts "Your last name is #{last_name}"

print "Where are you city from? "
city = gets.chomp
city.capitalize!
puts "Your city is #{city}"

print "Which state?"
state  = gets.chomp
state.upcase!
puts "Your state is #{state}"
