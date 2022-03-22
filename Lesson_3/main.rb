=begin

1 Создавать станции
2 Создавать поезда
3 Создавать маршруты и управлять станциями в нем (добавлять, удалять)
4 Назначать маршрут поезду
5 Добавлять вагоны к поезду
6 Отцеплять вагоны от поезда
7 Перемещать поезд по маршруту вперед и назад
8 Просматривать список станций и список поездов на станции

=end
require_relative 'station'
require_relative 'train'
require_relative 'cargoTrain'
require_relative 'passengerTrain'
require_relative 'route'

def main
  choice = 1
  while choice != 0
    puts "1 - Создать станцию"
    puts "2 - Создать поезд"
    puts "3 - Создать и изменить маршрут"
    puts "4 - Назначить маршрут поезду"
    puts "5 - Добавить вагоны к поезду"
    puts "6 - Отцеплять вагоны от поезда"
    puts "7 - Перемещать поезд по маршруту вперед и назад"
    puts "8 - Просматривать список станций и список поездов на станции"
    puts "9 - Выйти из программы"  
    print "Выберете номер пункта меню: "
    choice = gets.chomp.to_i
    if choice == 1
         make_station
    elsif choice == 2
     
    elsif choice == 3
      
    elsif choice == 4
     
    elsif choice == 5
     
    elsif choice == 6
     
    elsif choice == 7
     
    elsif choice == 8
     
    elsif choice == 9
     
    else
      puts "Пункт меню отствутствует"
    end
  end
end

def make_station
  print "Введите название станции: "
  name = gets.chomp.to_sym
  st = Station.new(name)
  puts "Станция #{st.name.to_s} создана"
end

main