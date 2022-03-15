=begin

Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
Найти порядковый номер даты, начиная отсчет с начала года.
Учесть, что год может быть високосным.

=end


print "Введите число, месяц, год через пробел: "
day, month, year = gets.chomp.split.map{|x| x.to_i}

days_in_mon_hash = {
    1 => 31,
    2 => 28,
    3 => 31,
    4 => 30,
    5 => 31,
    6 => 30,
    7 => 31,
    8 => 31,
    9 => 30,
    10 => 31,
    11 => 30,
    12 => 31,
}

if year % 400 == 0 || (year % 100 != 0 && year % 4 == 0)
    days_in_mon_hash[2] = 29
end

count_day = 0
(1...month).each do |month|
    count_day += days_in_mon_hash[month]
end

count_day += day
