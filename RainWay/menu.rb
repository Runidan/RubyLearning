class Menu 
  attr_reader :routes

  def initialize
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
    main_menu = <<-menu
    1 - Создать станцию
    2 - Создать поезд
    3 - Создать и изменить маршрут
    4 - Назначить маршрут поезду
    5 - Добавить вагоны к поезду
    6 - Отцеплять вагоны от поезда
    7 - Перемещать поезд по маршруту вперед и назад
    8 - Просматривать список станций и список поездов на станции
    0 - Выйти из программы  
    Выберете номер пункта меню: 
    menu
    puts main_menu
  end

  def make_station
    print "\tВведите название станции (Одно слово на анг. или рус. языке с большой буквы): "
    name = gets.chomp.to_sym
    check = false
    Station.all.each do |station|
      check = true if station.name == name
    end
    if check
      puts "Станция с именем #{name} уже существует"
    else
      begin
       station = Station.new(name)
      rescue RailRoadExeption => e
        puts "=" * 10
        puts "Возникла ошибка: #{e.message}"
        puts "=" * 10
      else
        puts "\tСтанция #{station.name.to_s} создана"
      end
    end  
  end

  def make_train
    print "\tВведите номер поезда в формате 'ggg-111': "
    number = gets.chomp.to_sym
    print "\tВведите тип поезда (1 - Cargo, 2 - Passenger): "
    type = gets.chomp.to_i
    if type == 1
      class_train = CargoTrain
    else
      class_train = PassengerTrain
    end
    train = class_train.new(number)
    print "\tВведите количество вагонов: "
    wagons_count = gets.chomp.to_i
    wagons_count.times do
      train.add_wagon
    end

    rescue RailRoadExeption => e
      puts "=" * 10
      puts "Возникла ошибка: #{e.message}"
      puts "=" * 10
    else
      puts "\tПоезд №#{train.number.to_s} создан. Тип - #{train.type.to_s}, количество вагонов: #{train.train_wagons.size}"
  end  

  def make_route
    puts "\tСуществующие станции: "
    Station.all.each {|station| puts "\t#{Station.all.index(station) + 1} - #{station.name}"}
    print "\tВведите номер первой станции станции: "
    i = gets.chomp.to_sym - 1 
    print "\tВведите номер конечной станции: "
    j = gets.chomp.to_sym - 1
    rt = Route.new(Station.all[i], Station.all[j])
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
      Station.all.each {|station| puts "\t#{Station.alls.index(station) + 1} - #{station.name}"}
      print "\tВведите номер станции, которую хотите добавить: "
      i = gets.chomp.to_sym - 1
      route.add_station(Station.all[i])
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
    i = 1
    while i == 1
      train.add_wagon
      puts "Добавлен один вагон к поезду #{train.number}. \nВсего #{train.train_wagons.size} вагонов.\nДобавить ещё? (Нажмите 1 если да)"
      i = gets.chomp.to_i
    end
  end

  def delete_wagon_train
    puts "\n\tОт какого поезда отцепить вагон?"
    Train.trains.each do |train|
      if train.train_wagons.size != 0
        puts "#{Train.trains.index(train) + 1}: №#{train.number} Тип: #{train.type}, вагонов #{train.train_wagons.size}"
      end  
    end
    train = Train.trains[gets.chomp.to_i - 1]
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
      puts "Поезд находится на станции #{train.current_station.name}"
    end
  end

  def list_stations
    puts "Список станций и поездов на них:"
    Station.all.each do |station|
      puts "\tСтанция #{station.name.to_s}"
      station.trains.each do |train|
        puts "\t\tПоезд №#{train.number}"
      end
    end
    puts "\n"
  end

  def choose_train
    Train.trains.each do |train|
      puts "#{Train.trains.index(train) + 1}: № #{train.number} Тип: #{train.type}"
    end
    train = Train.trains[gets.chomp.to_i - 1]
  end

end