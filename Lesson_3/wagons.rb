class Wagons
  @@wagons_count = 0
  attr_reader :type, :train, :wagon_number

  def initialize(type)
    @type = type
    @@wagons_count += 1
    @wagon_number = @@wagons_count
  end

  def add_wagons_totrain(train)
    if self.type == train.type
      @train = train
      puts "Вагон №#{self.wagon_number} добавлет к поезду №#{train.number}"
    else
      puts "Тип вагона не соответвует типу поезда"
  end
end