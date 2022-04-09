# frozen_string_literal: true

module RoutesActions
  private

  def show_routemenu
    menu = <<~HERE
      1 - Создание нового маршрута
      2 - Изменить существующий маршрут
      0 - Выйти в основное меню
      Выберете пункт меню:
    HERE
    puts menu
  end

  def menu_route
    choice4 = 1
    m_rt = { 1 => :make_route, 2 => :edit_route }
    while choice4 != 0
      show_routemenu
      choice4 = gets.chomp.to_i
      m_rt.key?(choice4) ? method(m_rt[choice4]).call : choice4 = 0
    end
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
    k = st_toroute(route) while k == 1
  end

  def st_toroute(route)
    puts "\tСозданные станции: "
    Station.all.each { |station| puts "\t#{Station.alls.index(station) + 1} - #{station.name}" }
    print "\tВведите номер станции, которую хотите добавить: "
    i = gets.chomp.to_sym - 1
    route.add_station(Station.all[i])
    print "\tНажмите 1 если хотите ещё добавить промежуточную станцию "
    gets.chomp.to_i
  end
end
