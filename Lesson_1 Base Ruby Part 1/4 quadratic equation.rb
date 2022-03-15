=begin

Пользователь вводит 3 коэффициента a, b и с.
Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть)
и выводит значения дискриминанта и корней на экран.

=end

print "Введите коэффициент a: "
a = gets.chomp.to_i
print "Введите коэффициент b: "
b = gets.chomp.to_i
print "Введите коэффициент c: "
c = gets.chomp.to_i

discriminant = b**2 - 4 * a * c

if discriminant > 0
  puts "D = #{discriminant}"
  puts "x1 = #{(-b + Math.sqrt(discriminant)) / (2 * a)}"
  puts "x2 = #{(-b - Math.sqrt(discriminant)) / (2 * a)}"
elsif discriminant == 0
  puts "D = #{discriminant}"
  puts "x1 = x2 = #{-b / (2 * a)}"
else
  puts "Корней нет!"
end

