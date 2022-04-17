# frozen_string_literal: true

require_relative 'accessors'
require_relative 'validation'

class MyClass
  extend Accessors
  extend Validation::ClassMethods
  include Validation::InstanceMethods

  attr_accessor_with_history :ac1, :ac2, :ac3

  strong_attr_accessor :arg, Integer
  def initialize; end
end

mk = MyClass.new
p mk
mk.ac1 = 3
mk.ac1 = 4
p mk.ac1
p mk.ac1_history

begin
  p mk.arg = 3
  p mk.arg = 'string'
rescue TypeError => e
  puts "Возникла ошибка: #{e.message}"
end

p mk.valid?(:ac1, :type, Integer)
p mk.valid?(:ac1, :format, /0-9/)
p mk.valid?(:ac3, :presence)
