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

class Menu 
  attr_reader :stations, :trains, :routes, :wagons

  def initialize
    @stations = Hash.new
    @trains = []
    @routes = []
    @wagons = []
  end

  
  def main_menu
    choice = 1
      while choice != 0
        show_menu
        choice = gets.chomp.to_i
        if choice == 1 then make_station
        elsif choice == 2 then make_train
        elsif choice == 3 
          print "\n\tВведите 1 для создания или 2 для редактирования маршрута: "
          gets.chomp.to_i == 1 ? make_route : edit_route
        elsif choice == 4 then add_route_train
        elsif choice == 5 then add_wagons_train
        elsif choice == 6 then delete_wagon_train
        elsif choice == 7 then move_train
         
        elsif choice == 8
         
        elsif choice == 0
          puts "Спасибо, всего доброго!"
        else
          puts "Пункт меню отствутствует\n\n"
        end
      end
  end

  private

  def show_menu
    puts "\n1 - Создать станцию"
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

  def make_station
    print "\tВведите название станции: "
    name = gets.chomp.to_sym
    if @stations.has_key?(name)
      puts "Станция с именем #{name} уже существует"
    else
      station = Station.new(name)
      @stations[name] = station
      puts "\tСтанция #{station.name.to_s} создана"
    end  
  end

  def make_train
    print "\tВведите номер поезда: "
    number = gets.chomp.to_sym
    print "\tВведите тип поезда (1 - Cargo, 2 - Passenger): "
    type = gets.chomp.to_i
    type == 1 ? type = :cargo : type = :passenger
    print "\tВведите количество вагонов: "
    vagons_count = gets.chomp.to_i
    train = Train.new(number, type, vagons_count)
    @trains << train
    puts "\tПоезд №#{train.number.to_s} создан. Тип - #{train.type.to_s}, вагонов: #{train.vagons_count.to_s}"
  end  

  def make_route
    puts "\tСозданные станции: "
    @stations.each {|name, station| puts "\t - #{name}"}
    print "\tВведите имя первой станции станции: "
    key = gets.chomp.to_sym
    first_station = @stations[key] if @stations.has_key?(key)
    print "\tВведите имя конечной станции: "
    key = gets.chomp.to_sym
    last_station = @stations[key] if @stations.has_key?(key)
    rt = Route.new(first_station, last_station)
    @routes << rt
    puts "Создан маршрут #{rt.stations.first.name} - #{rt.stations.last.name}"
  end

  def edit_route
    puts "\tВыберете номер маршрута для редактирования:"
    @routes.each do |route|
      puts "\t#{@routes.index(route) + 1}: #{route.stations.first.name}-#{route.stations.last.name}"
    end
    i = gets.chomp.to_i - 1
    route = @routes[i]
    print "\tНажмите 1 если хотите добавить промежуточную станцию "
    k = gets.chomp.to_i
    while k == 1
      puts "\tСозданные станции: "
      @stations.each {|name, station| puts "\t- #{name}"}
      print "\tВведите имя станции, которую хотите добавить: "
      station_name = gets.chomp.to_sym
      route.add_station(@stations[station_name]) if @stations.has_key?(station_name)
      print "\tНажмите 1 если хотите ещё добавить промежуточную станцию "
      k = gets.chomp.to_i
    end  
  
  
  end

  def add_route_train
    puts "\n\tВыберете номер маршрута для добавления: "
    @routes.each do |route|
      puts "\t#{@routes.index(route) + 1}: #{route.stations.first.name}-#{route.stations.last.name}"
    end
    i = gets.chomp.to_i - 1
    route = @routes[i]

    puts "\n\tВыберете поезд для добавления маршрута: "
    train = choose_train
    train.add_route(route)
    puts "Маршрут #{route.stations.first.name}-#{route.stations.last.name} добавлен поезду №#{train.number}"
  end

  def add_wagons_train
    puts "\tК какому поезду прицепить вагон?"
    train = choose_train
    type = train.type
    if type == :cargo
      wg = CargoWagon.new
    else
      wg = PassengerWagon.new
    end
    train.add_wagon(wg)
  end

  def delete_wagon_train
    puts "\n\tОт какого поезда отцепить вагон?"
    train = choose_train
    train.delete_wagon
  end

  def move_train
    train = choose_train
    choose
    unless choose
      puts "\n\tВыберете: "
      puts "\t1: Движение вперед"
      puts "\t2: Движение назад"
      puts "\t0: Выйти в основное меню"
      case gets.chomp.to_i
      when 1 then train.go_next_station
      when 2 then train.go_previos_station
      when 0 then choose = True
      else
        puts "Повторите выбор\n\n"
      end
    end
  end

  def choose_train
    @trains.each do |train|
      if train.train_wagons != nil
        puts "#{@trains.index(train) + 1}: №#{train.type} Тип: #{train.type}"
      end  
    end
    @trains[gets.chomp.to_i - 1]
  end
end