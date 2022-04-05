class Menu 
  attr_reader :routes

  def initialize
      @routes = []
  end

  def main_menu
    choice0 = 1
      while choice0 != 0
        show_menu
        choice0 = gets.chomp.to_i
        case choice0
          when 1 then menu_stations
          when 2 then make_train
          when 3 then menu_train
          when 4 then menu_route
          when 0 then choice = 0 
          else 
            puts "Пункт меню отствутствует\n\n"
        end
      end
  end

  private

  def show_menu
    main_menu = <<-menu
    Выберете действие:
    1 - Действия со станциями
    2 - Создать поезд
    3 - Действия с поездами и вагонами
    4 - Действия с маршрутами
    0 - Выйти из программы  
    menu
    puts main_menu
  end

  def menu_stations
    menu = <<~here
      1 - Создать станцию
      2 - Просмотреть список станций и список поездов на станциях
      0 - Главное меню
    Выберете действие:
    here
    choice = 1
    until choice == 0
      puts menu
      choice = gets.chomp.to_i
      case choice
      when 1 then make_station
      when 2 then list_stations
      else
        puts "Повторите выбор"
      end
    end
  end

  def menu_train
    puts "\tВыберете поезд:"
    train = choose_train
    menu = <<~here
    1 - Показать список вагонов
    2 - Добавить вагон к поезду
    3 - Отцепить вагон от поезда
    4 - Назначить поезду существующий маршрут
    5 - Перемещать поезд по маршруту
    6 - Занять место/Загрузить вагон
    0 - Вернуться в главное меню 
    here
    choice3 = 1
    until choice3 == 0
      puts menu
      choice3 = gets.chomp.to_i
      case choice3
        when 1 then show_wagons(train)
        when 2 then add_wagons_train(train)
        when 3 then delete_wagon_train(train)
        when 4 then add_route_train(train)
        when 5 then move_train(train)
        when 6 then take_place(train)
        else 
          puts "Выбор неверный. Повторите\n\n"
      end
    end
  end

  def menu_route
    menu = <<~here
      1 - Создание нового маршрута
      2 - Изменить существующий маршрут
      0 - Выйти в основное меню
      Выберете пункт меню:
    here
    choice4 = 1
    while choice4 != 0
      puts menu
      choice4 = gets.chomp.to_i
      case choice4
      when 1 then make_route
      when 2 then edit_route
      else 
          puts "Повторите выбор"
      end
    end
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
    class_train = gets.chomp.to_i == 1 ? CargoTrain : PassengerTrain
    train = class_train.new(number)
    print "\tВведите количество вагонов: "
    wagons_count = gets.chomp.to_i
    if class_train == CargoTrain
      print "\tВведите грузоподъемность вагонов: "
    else
      print "\tВведите вместимость вагонов: "
    end
    place = gets.chomp.to_i
    wagons_count.times do
      train.add_wagon(place)
    end

    rescue RailRoadExeption => e
      puts "=" * 10
      puts "Возникла ошибка: #{e.message}"
      puts "=" * 10
    else
      puts "=" * 10
      puts "Поезд № #{train.number.to_s} создан. Тип - #{train.type.to_s}, количество вагонов: #{train.wagons.size}"
      puts "=" * 10
  end  

  def make_route
    puts "\tСуществующие станции: "
    Station.all.each {|station| puts "\t#{Station.all.index(station) + 1} - #{station.name}"}
    print "\tВведите номер первой станции станции: "
    i = gets.chomp.to_i - 1 
    print "\tВведите номер конечной станции: "
    j = gets.chomp.to_i - 1
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

  def add_route_train(train)
    puts "\n\tВыберете номер маршрута для добавления: "
    @routes.each do |route|
      puts "\t#{@routes.index(route) + 1}: #{route.stations.first.name}-#{route.stations.last.name}"
    end
    i = gets.chomp.to_i - 1
    route = @routes[i]

    train.add_route(route)
    puts "Маршрут #{route.stations.first.name}-#{route.stations.last.name} добавлен поезду №#{train.number}"
  end

  def add_wagons_train(train)
    i = 1
    while i == 1
      puts train.type == :cargo ? "\tУкажите грузоподъемность вагона:" : "\tУкажите вместимость вагона:"
      place = gets.chomp.to_i
      train.add_wagon(place)
      puts "Добавлен один вагон к поезду #{train.number}. \nВсего #{train.wagons.size} вагонов.\nДобавить ещё? (Нажмите 1 если да)"
      i = gets.chomp.to_i
    end
  end

  def delete_wagon_train(train)
    i = 1
    while i == 1
      if train.wagons.size != 0
        puts "Выберете номер вагона для удаления"
        show_wagons(train)
        i_wagon = gets.chomp.to_i
        train.delete_wagon(i_wagon)
        puts "Удалён один вагон. Осталось #{train.wagons.size}. Удалить еще? (Нажмите 1 если да)"
        i = gets.chomp.to_i
      else
        puts "Поезд № #{train.number} не имеет вагонов"
        i = 0
      end
    end

  end

  def move_train(train)
    i = 1
    while i == 1
      puts "\n\tВыберете: "
      puts "\t1: Движение вперед"
      puts "\t2: Движение назад"
      puts "\t0: Выйти"
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
        puts "\t\tПоезд №#{train.number}, тпи #{train.type}, вагонов: #{train.wagons.size}"
      end
    end
    puts "\n"
  end

  def show_wagons(train)
    train.wagons.each do |wagon|
      puts "#{train.wagons.index(wagon) + 1}: № #{wagon.number} Свободно: #{wagon.free_place}"
    end
  end

  def take_place(train)
    puts "Выберете вагон:"
    show_wagons(train)
    wagon = train.wagons[gets.chomp.to_i - 1]
    if wagon.type == :cargo
      puts "Свободно #{wagon.free_place}. Сколько хотите занять: "
      wagon.take_place(gets.chomp.to_f)
      puts "Груз в вагон #{wagon.number} поезда #{train.number} загружет. Осталось свободно #{wagon.free_place}"
    else
      wagon.take_place
      puts "Место в вагоне #{wagon.number} поезда #{train.number} занято. Осталось свободных мест #{wagon.free_place}"
    end
  end

  def choose_train
    Train.trains.each do |train|
      puts "#{Train.trains.index(train) + 1}: № #{train.number} Тип: #{train.type} Количество вагонов: #{train.wagons.size}"
    end
    train = Train.trains[gets.chomp.to_i - 1]
  end

end