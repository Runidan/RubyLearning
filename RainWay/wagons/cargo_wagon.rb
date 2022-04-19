# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize(place)
    super(:cargo, place, @@wagons_count)
    rdx = Regexp.new("/^cr[0-9]*$/i")
    validate!(:number, :format, rdx)
  end

  def take_place(volume)
    raise RailRoadExeption, 'Недостаточно места' unless @place - @used_place >= volume

    @used_place += volume
  end
end
