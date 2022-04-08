# frozen_string_literal: true

class Menu
  attr_reader :routes

  def initialize
    @routes = []
  end

  def main_menu
    choice0 = 1
    m_main = { 1 => :menu_stations, 2 => :make_train, 3 => :menu_train, 4 => :menu_route }
    while choice0 != 0
      show_mainmenu
      choice0 = gets.chomp.to_i
      method(m_main[choice0]).call ? m_main.key?(choice0) : choice0 = 0
    end
  end

  private

  def show_mainmenu
    main_menu = <<-MENU
    Выберете действие:
    1 - Действия со станциями
    2 - Создать поезд
    3 - Действия с поездами и вагонами
    4 - Действия с маршрутами
    0 - Выйти из программы#{'  '}
    MENU
    puts main_menu
  end

  def show_stmenu
    menu = <<~HERE
      1 - Создать станцию
      2 - Просмотреть список станций и список поездов на станциях
      0 - Главное меню
      Выберете действие:
    HERE
    puts menu
  end

  def show_trmenu
    menu = <<~HERE
      1 - Показать список вагонов
      2 - Добавить вагон к поезду
      3 - Отцепить вагон от поезда
      4 - Назначить поезду существующий маршрут
      5 - Перемещать поезд по маршруту
      6 - Занять место/Загрузить вагон
      0 - Вернуться в главное меню#{' '}
    HERE
    puts menu
  end

  def show_routemenu
    menu = <<~HERE
      1 - Создание нового маршрута
      2 - Изменить существующий маршрут
      0 - Выйти в основное меню
      Выберете пункт меню:
    HERE
    puts menu
  end

  def menu_stations
    choice1 = 1
    until choice1.zero?
      show_stmenu
      m = { 1 => :make_station, 2 => :list_stations }
      choice1 = gets.chomp.to_i
      method(m[choice1]).call ? m.key?(choice1) : choice1 = 0
    end
  end

  def menu_train
    puts "\tВыберете поезд:"
    train = choose_train
    choice3 = 1
    until choice3.zero?
      show_trmenu
      choice3 = gets.chomp.to_i
      m_tr = { 1 => :show_wagons,
               2 => :add_wagons_train,
               3 => :delete_wagon_train,
               4 => :add_route_train,
               5 => :move_train,
               6 => :take_place }
      method(m_tr[choice3]).call(train) ? m_tr.key?(choice3) : choice3 = 0
    end
  end

  def menu_route
    choice4 = 1
    while choice4 != 0
      show_routemenu
      choice4 = gets.chomp.to_i
      m_rt = { 1 => :make_route, 2 => edit_route }
      method(m_tr[choice4]).call ? m_rt.key?(choice4) : choice4 = 0
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
        puts '=' * 10
        puts "Возникла ошибка: #{e.message}"
        puts '=' * 10
      else
        puts "\tСтанция #{station.name} создана"
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
    puts '=' * 10
    puts "Возникла ошибка: #{e.message}"
    puts '=' * 10
  else
    puts '=' * 10
    puts "Поезд № #{train.number} создан. Тип - #{train.type}, количество вагонов: #{train.wagons.size}"
    puts '=' * 10
  end

  def make_route
    puts "\tСуществующие станции: "
    Station.all.each { |station| puts "\t#{Station.all.index(station) + 1} - #{station.name}" }
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
      Station.all.each { |station| puts "\t#{Station.alls.index(station) + 1} - #{station.name}" }
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
      if !train.wagons.empty?
        puts 'Выберете номер вагона для удаления'
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
    puts 'Список станций и поездов на них:'
    Station.all.each do |station|
      puts "\tСтанция #{station.name}"
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
    puts 'Выберете вагон:'
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
