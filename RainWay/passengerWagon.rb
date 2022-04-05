require_relative 'wagon'
require_relative 'instanceCounter'

class PassengerWagon < Wagon


  def initialize(place)
    @type = :passenger
    @place = place
    @used_place = 0
    @@wagons_count += 1
    @number = "ps#{@@wagons_count.to_s}"
    self.class.instances
  end

  def valid?
    validete!
  end

  def take_place 
    if @place > @used_place
      @used_place += 1
    else
      raise RailRoadExeption.new("Свободных мест нет")
    end
  end

  protected
  def validate!
    errors = []
    errors << "Неверно определен тип вагона" if !@@wagon_type.include?(@type)
    errors << "Неверный формат номера вагона" if @number !~ /^ps[0-9]*$/i
    errors << "Номер вагона не может быть пустым" if @number.nil?
    errors << "Вместимость вагона не является целым числом" unless @place.integer?
    errors << "Вместимость вагона может быть от 0 до 150" unless @place.between? 0, 150
    raise RailRoadExeption.new(errors.join("\n")) unless errors.empty?
    true
  end


end  