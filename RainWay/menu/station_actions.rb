# frozen_string_literal: true

module StationActions
  private

  def show_stmenu
    menu = <<~HERE
      1 - Создать станцию
      2 - Просмотреть список станций и список поездов на станциях
      0 - Главное меню
      Выберете действие:
    HERE
    puts menu
  end

  def menu_stations
    choice1 = 1
    m = { 1 => :make_station, 2 => :list_stations }
    until choice1.zero?
      show_stmenu
      choice1 = gets.chomp.to_i
      m.key?(choice1) ? method(m[choice1]).call : choice1 = 0
    end
  end

  def make_station
    name = check_station
    begin
      station = Station.new(name)
    rescue RailRoadExeption => e
      puts "==========\nВозникла ошибка: #{e.message}\n=========="
    else
      puts "\tСтанция #{station.name} создана"
    end
  end

  def check_station
    check = true
    while check
      check = false
      print "\tВведите название станции (Одно слово на анг. или рус. языке с большой буквы): "
      name = gets.chomp.to_sym
      Station.all.each { |station| check = true if station.name == name }
      puts "Станция с именем #{name} уже существует" if check
    end
    name
  end

  def list_stations
    ls_tr = lambda do |station|
      station.trains.each do |train|
        puts "\t\tПоезд №#{train.number}, тип #{train.type}, вагонов: #{train.wagons.size}"
      end
    end
    puts 'Список станций и поездов на них:'
    Station.all.each do |station|
      puts "\tСтанция #{station.name}:"
      ls_tr.call(station)
    end
  end
end
