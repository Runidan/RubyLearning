=begin
Программа запрашивает у пользователя 3 стороны треугольника и определяет, является ли треугольник прямоугольным,
равнобедренным  или равносторонним и выводит результат на экран.
=end

print "Введите длину стороны 1: "
hypotenuse = gets.chomp.to_f
print "Введите длину стороны 2: "
leg1 = gets.chomp.to_f
hypotenuse, leg1 = leg1, hypotenuse if leg1 > hypotenuse
print "Введите длину стороны 3: "
leg2 = gets.chomp.to_f
hypotenuse, leg2 = leg2, hypotenuse if leg2 > hypotenuse

if hypotenuse**2 == leg1**2 + leg2**2
  puts "Треугольник является прямоугольным"
elsif hypotenuse == leg1 && hypotenuse == leg2
  puts "Треугольник является равносторонним"
elsif hypotenuse == leg1 || hypotenuse == leg2
  puts "Треугольник является равнобедренным"
else
  puts "Треугольник не является ни прямоугольным, ни равносторонним, ни равнобедренным"
end
