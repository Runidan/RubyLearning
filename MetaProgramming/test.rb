require_relative 'acsrs'
require_relative 'validation'

class MyClass
  extend Accessors
  extend Validation

  attr_accessor_with_history :ac1, :ac2, :ac3

  strong_attr_accessor :arg, Integer
  def initialize
  end

  def valid?(name_arg, form_arg, *arg)
    validate!(name_arg, form_arg, *arg)
  end

  def validate!(name_arg, form_arg, *arg)
    self.class.validate(name_arg, form_arg, *arg)
    rescue TypeError => e
      puts "Возникла ошибка #{e.class}: #{e.message}"
      return false
    else
      return true
  end
end

mk = MyClass.new
p mk
mk.ac1 = 3
mk.ac1 = 4
p mk.ac1
p mk.ac1_history

