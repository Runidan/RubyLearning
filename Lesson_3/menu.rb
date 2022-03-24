class Menu 
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
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
        elsif choice == 8 then list_stations
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
    check = false
    @stations.each do |station|
      check = true if station.name == name
    end
    if check
      puts "Станция с именем #{name} уже существует"
    else
      station = Station.new(name)
      @stations << station
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
    puts "\tСуществующие станции: "
    @stations.each {|station| puts "\t#{@stations.index(station) + 1} - #{station.name}"}
    print "\tВведите номер первой станции станции: "
    i = gets.chomp.to_sym - 1 
    print "\tВведите номер конечной станции: "
    j = gets.chomp.to_sym - 1
    rt = Route.new(@stations[i], @stations[j])
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
      @stations.each {|station| puts "\t#{@stations.index(station) + 1} - #{station.name}"}
      print "\tВведите номер станции, которую хотите добавить: "
      i = gets.chomp.to_sym - 1
      route.add_station(@stations[i])
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
    i = 1
    while i == 1
      if type == :cargo
        train.add_wagon(CargoWagon.new)
      else
        train.add_wagon(PassengerWagon.new)
      end
      puts "Добавлен один вагон к поезду #{train.number}. \nВсего #{train.train_wagons.size} вагонов.\nДобавить ещё? (Нажмите 1 если да)"
      i = gets.chomp.to_i
    end
  end

  def delete_wagon_train
    puts "\n\tОт какого поезда отцепить вагон?"
    @trains.each do |train|
      if train.train_wagons.size != 0
        puts "#{@trains.index(train) + 1}: №#{train.number} Тип: #{train.type}, вагонов #{train.train_wagons.size}"
      end  
    end
    train = @trains[gets.chomp.to_i - 1]
    i = 1
    while i == 1
      train.delete_wagon
      if train.train_wagons.size != 0
        puts "Удалён один вагон. Осталось #{train.train_wagons.size}. Удалить еще? (Нажмите 1 если да)"
        i = gets.chomp.to_i
      else
        puts "Поезд № #{train.number} не имеет вагонов"
        i = 0
      end
    end

  end

  def move_train
    puts "\tВыберете поезд"
    train = choose_train
    i = 1
    while i == 1
      puts "\n\tВыберете: "
      puts "\t1: Движение вперед"
      puts "\t2: Движение назад"
      puts "\t0: Выйти в основное меню"
      case gets.chomp.to_i
      when 1 then train.go_next_station
      when 2 then train.go_previos_station
      when 0 then i = 0
      else
        puts "Повторите выбор\n\n"
      end
    end
  end

  def list_stations
    puts "Список станций и поездов на них:"
    @station.each do |station|
      puts "\tСтанция #{station.name.to_s}"
      station.trains.each do |train|
        puts "\t\tПоезд №#{train.number}"
      end
    end
    puts "\n"
  end

  def choose_train
    @trains.each do |train|
      puts "#{@trains.index(train) + 1}: № #{train.number} Тип: #{train.type}"
    end
    train = @trains[gets.chomp.to_i - 1]
  end

end