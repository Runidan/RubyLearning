require_relative 'wagon'
require_relative 'instanceCounter'

class CargoWagon < Wagon

  def initialize(place)
    @type = :cargo
    @place = place
    @used_place = 0
    @@wagons_count += 1
    @number = "cr#{@@wagons_count}"
    self.class.instances
  end

  def valid?
    validete!
  end

  def take_place(volume)
    if @place - @used_place >= volume
      @used_place += volume
    else
      raise RailRoadExeption.new("Недостаточно места")
    end
  end

  protected
  def validate!
    errors = []
    errors << "Неверно определен тип вагона" if !@@wagon_type.include?(@type)
    errors << "Неверный формат номера вагона" if @number !~ /^cr[0-9]*$/i
    errors << "Номер вагона не может быть пустым" if @number.nil?
    errors << "Вместимость вагона не является числом" unless @place.scan(/\D/).empty?
    errors << "Грузоподъемность вагона может быть от 0 до 200" unless (0..200).include?(@place)
    raise RailRoadExeption.new(errors.join("\n")) unless errors.empty?
    true
  end


end 