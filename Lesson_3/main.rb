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
require_relative 'wagons'

stations = Hash.new
trains = []
routes = []
wagons = []

def main(stations, trains, routes, wagons)
  choice = 1
  while choice != 0
    show_menu
    choice = gets.chomp.to_i
    if choice == 1 then make_station(stations)
    elsif choice == 2 then make_train(trains)
    elsif choice == 3 
      print "\tВведите 1 для создания или 2 для редактирования маршрута: "
      gets.chomp.to_i == 1 ? make_route(stations, routes) : edit_route(stations, routes)
    elsif choice == 4
      
    elsif choice == 5
     
    elsif choice == 6
     
    elsif choice == 7
     
    elsif choice == 8
     
    elsif choice == 0
      puts "Спасибо, всего доброго!"
    else
      puts "Пункт меню отствутствует"
    end
  end
end

def show_menu
  puts "1 - Создать станцию"
  puts "2 - Создать поезд"
  puts "3 - Создать и изменить маршрут"
  puts "4 - Назначить маршрут поезду"
  puts "5 - Добавить вагоны к поезду"
  puts "6 - Отцеплять вагоны от поезда"
  puts "7 - Перемещать поезд по маршруту вперед и назад"
  puts "8 - Просматривать список станций и список поездов на станции"
  puts "0 - Выйти из программы"  
  print "Выберете номер пункта меню: "
end

def make_station(stations)
  print "\tВведите название станции: "
  name = gets.chomp.to_sym
  if stations.has_key?(name)
    puts "Станция с именем #{name} уже существует"
  else
    station = Station.new(name)
    stations[name] = station
    "\tСтанция #{station.name.to_s} создана"
    p stations
  end  
end

def make_train(trains)
  print "\tВведите номер поезда: "
  number = gets.chomp.to_sym
  print "\tВведите тип поезда (1 - Cargo, 2 - Passenger): "
  type = gets.chomp.to_i
  type == 1 ? type = :cargo : type = :passenger
  print "\tВведите количество вагонов: "
  vagons_count = gets.chomp.to_i
  train = Train.new(number, type, vagons_count)
  trains << train
  puts "\tПоезд №#{train.number.to_s} создан. Тип - #{train.type.to_s}, вагонов: #{train.vagons_count.to_s}"
end  

def make_route(stations, routes)
  puts "\tСозданные станции: "
  stations.each {|name, station| puts "\t- #{name}"}
  print "\tВведите имя первой станции станции: "
  key = gets.chomp.to_sym
  first_station = stations[key] if stations.has_key?(key)
  print "\tВведите имя конечной станции: "
  key = gets.chomp.to_sym
  last_station = stations[key] if stations.has_key?(key)
  rt = Route.new(first_station, last_station)
  routes << rt
  puts "Создан маршрут #{rt.stations.first.name} - #{rt.stations.last.name}"
end

def edit_route(stations, routes)
  puts "\tВыберете номер маршрута для редактирования:"
  routes.each do |route|
    puts "\t#{routes.index(route) + 1}: #{route.stations.first.name}-#{route.stations.last.name}"
  end
  i = gets.chomp.to_i - 1
  route = routes[i]
  print "\tНажмите 1 если хотите добавить промежуточную станцию "
  k = gets.chomp.to_i
  while k == 1
    puts "\tСозданные станции: "
    stations.each {|name, station| puts "\t- #{name}"}
    print "\tВведите имя станции, которую хотите добавить: "
    station_name = gets.chomp.to_sym
    route.add_station(stations[station_name]) if stations.has_key?(station_name)
    print "\tНажмите 1 если хотите ещё добавить промежуточную станцию "
    k = gets.chomp.to_i
  end  


end

def seed(stations, trains, routes, wagons)
  st1 = Station.new(:Златоуст)
  stations[st1.name] = st1
  st2 = Station.new(:Аша)
  stations[st2.name] = st2
  st3 = Station.new(:Уфа)
  stations[st3.name] = st3
  st4 = Station.new(:Самара)
  stations[st4.name] = st4
  st5 = Station.new(:Нижний)
  stations[st5.name] = st5
  st6 = Station.new(:Рязань)
  stations[st6.name] = st6
  st7 = Station.new(:Москва)
  stations[st7.name] = st7

  rt1 = Route.new(st1, st7)
  rt2 = Route.new(st6, st1)
  rt1.add_station(st2)
  rt1.add_station(st3)
  rt1.add_station(st4)
  rt1.add_station(st5)
  rt1.add_station(st6)
  rt2.add_station(st5)
  routes << rt1
  routes << rt2

  tr1 = Train.new(13, :cargo, 15)
  tr1.add_route(rt1)
  trains << tr1
  tr2 = Train.new(181, :passenger, 12)
  tr2.add_route(rt2)
  trains << tr2

end


seed(stations, trains, routes, wagons)
main(stations, trains, routes, wagons)