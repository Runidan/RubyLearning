=begin
Площадь треугольника можно вычислить, зная его основание (a) и высоту (h) по формуле: 1/2*a*h.
 Программа должна запрашивать основание и высоту треугольника и возвращать его площадь.
=end


print "Введите основание треугольника: "
a = gets.chomp.to_f
print "Введите высоту треугольника: "
h = gets.chomp.to_f
puts "Площадь треугольника равна #{1.0 / 2 * a * h}"