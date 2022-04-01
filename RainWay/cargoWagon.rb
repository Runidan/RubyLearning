require_relative 'wagon'
require_relative 'instanceCounter'

class CargoWagon < Wagon

  def initialize
    @type = :cargo
    @@wagons_count += 1
    @number = "cr#{@@wagons_count.to_s}"
    self.class.instances
  end

  def valid?
    validete!
  end

  protected
  def validate!
    raise RailRoadExeption.new("Неверно определен тип вагона") if !@@wagon_type.include?(@type)
    raise RailRoadExeption.new("Неверный формат номера вагона") if @number !~ /^cr[0-9]*$/i
    raise RailRoadExeption.new("Номер вагона не может быть пустым") if @number.nil?
    true
  end


end 