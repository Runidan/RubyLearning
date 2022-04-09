# frozen_string_literal: true

module WagonActions
  private

  def add_wagons_train(train)
    i = 1
    while i == 1
      puts train.type == :cargo ? "\tУкажите грузоподъемность вагона:" : "\tУкажите вместимость вагона:"
      place = gets.chomp.to_i
      train.add_wagon(place)
      puts "Добавлен один вагон к поезду #{train.number}. \nВсего #{train.wagons.size} вагонов.
      \nДобавить ещё? (Нажмите 1 если да)"
      i = gets.chomp.to_i
    end
  end

  def delete_wagon_train(train)
    i = 1
    while i == 1 && !train.wagons.empty?
      puts 'Выберете номер вагона для удаления'
      show_wagons(train)
      i_wagon = gets.chomp.to_i
      train.delete_wagon(i_wagon)
      puts "Удалён один вагон. Осталось #{train.wagons.size}. Удалить еще? (Нажмите 1 если да)"
      i = gets.chomp.to_i
    end
    puts "Поезд № #{train.number} не имеет вагонов" if train.wagons.empty?
  end

  def show_wagons(train)
    puts 'Вагоны:'
    train.wagons.each do |wagon|
      puts "#{train.wagons.index(wagon) + 1}: № #{wagon.number} Свободно: #{wagon.free_place}"
    end
  end

  def take_place(train)
    show_wagons(train)
    wagon = train.wagons[gets.chomp.to_i - 1]
    if wagon.type == :cargo
      puts "Свободно #{wagon.free_place}. Сколько хотите занять: "
      wagon.take_place(gets.chomp.to_f)
    else
      wagon.take_place
    end
    puts "В вагоне № #{wagon.number} поезда № #{train.number} свободно #{wagon.free_place}"
  end
end
