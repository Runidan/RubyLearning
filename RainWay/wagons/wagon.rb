# frozen_string_literal: true

class Wagon
  extend Validation
  include InstanceCounter
  include Manufacturer

  @@wagons_count = 1
  @@wagon_type = %i[cargo passenger]

  attr_reader :type, :place, :taked_place
  attr_accessor :number

  validate

  def initialize(type, place, number = @@wagons_count)
    @type = type
    validate!(:type, :presence)
    @number = String(@type == :cargo ? "cr#{number}" : "ps#{number}")
    @place = place
    validate!(:place, :type, Integer)
    rdx = Regexp.new("/^(cr|ps)[0-9]*$/i")
    validate!(:number, :format, rdx)
    @used_place = 0
    @@wagons_count += 1
    register_instance
  end

  def free_place
    @place - @used_place
  end

end
