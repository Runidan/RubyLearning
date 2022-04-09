# frozen_string_literal: true

module TrainActions
  protected

  def show_trmenu
    menu = <<~HERE
      1 - Показать список вагонов
      2 - Добавить вагон к поезду
      3 - Отцепить вагон от поезда
      4 - Назначить поезду существующий маршрут
      5 - Перемещать поезд по маршруту
      6 - Занять место/Загрузить вагон
      0 - Вернуться в главное меню
    HERE
    puts menu
  end

  def show_movetrmenu
    menu_movetr = <<-HERE
      1 - Движение вперед
      2 - Движение назад
      0 - Выйти
      Выберете:
    HERE
    puts menu_movetr
  end

  def menu_train
    puts "\tВыберете поезд:"
    train = choose_train
    choice3 = 1
    m_tr = { 1 => :show_wagons, 2 => :add_wagons_train, 3 => :delete_wagon_train,
             4 => :add_route_train, 5 => :move_train, 6 => :take_place }
    until choice3.zero?
      show_trmenu
      choice3 = gets.chomp.to_i
      m_tr.key?(choice3) ? method(m_tr[choice3]).call(train) : choice3 = 0
    end
  end

  def choose_train
    Train.trains.each do |train|
      puts "#{Train.trains.index(train) + 1}: № #{train.number}
      Тип: #{train.type} Количество вагонов: #{train.wagons.size}"
    end
    Train.trains[gets.chomp.to_i - 1]
  end

  def make_train
    train, wagons_count, place = param_train
    wagons_count.times do
      train.add_wagon(place)
    end
  rescue RailRoadExeption => e
    puts "==========\nВозникла ошибка: #{e.message}\n=========="
  else
    puts "======\nПоезд № #{train.number} создан. Тип - #{train.type}, количество вагонов: #{train.wagons.size}\n======"
  end

  def param_train
    print "\tВведите номер поезда в формате 'ggg-111': "
    number = gets.chomp.to_sym
    print "\tВведите тип поезда (1 - Cargo, 2 - Passenger): "
    class_train = gets.chomp.to_i == 1 ? CargoTrain : PassengerTrain
    train = class_train.new(number)
    print "\tВведите количество вагонов: "
    wagons_count = gets.chomp.to_i
    print "\tВведите вместимость (грузоподъемность) вагонов: "
    place = gets.chomp.to_i
    [train, wagons_count, place]
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

  def move_train(train)
    i = 1
    while i == 1
      show_movetrmenu
      case gets.chomp.to_i
      when 1 then train.go_next_station
      when 2 then train.go_previos_station
      when 0 then i = 0
      end; puts "Поезд находится на станции #{train.current_station.name}"
    end
  rescue RailRoadExeption => e; puts "=====\nВозникла ошибка: #{e.message}\n====="
  end
end
