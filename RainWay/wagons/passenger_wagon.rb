# frozen_string_literal: true

class PassengerWagon < Wagon
  def initialize(place)
    super(:passenger, place, @@wagons_count)
    rdx = Regexp.new("/^ps[0-9]*$/i")
    validate!(:number, :format, rdx)
  end



  def take_place
    raise RailRoadExeption, 'Свободных мест нет' unless @place > @used_place

    @used_place += 1
  end
end
