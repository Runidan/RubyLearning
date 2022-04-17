# frozen_string_literal: true

module Validation
  module ClassMethods
    def validate(name, type, *args)
      raise TypeError, "#{name}  is not symbol" unless name.is_a?(Symbol)
      raise TypeError, "#{type}  is not symbol" unless type.is_a?(Symbol)
      raise TypeError, "#{type}  может быть только :presence, :format или :type" unless %i[presence format
                                                                                           type].include?(type)

      arg = instance_variable_get("@#{name}")
      raise TypeError, "#{name} не может быть пустым" if type == :presence && (arg.nil? || arg.empty?)

      if type == :format && !args[0].instance_of?(Regexp)
        raise TypeError,
              "#{args[0]} не является регулярным выражением"
      end
      raise TypeError, "#{name} не соответствует регулярному выражению" if type == :format && arg =~ args[0]

      if type == :type && !args[0].class.instance_of?(Class)
        raise TypeError,
              "#{args[0]} не является классом (третий аргумент)"
      end
      raise TypeError, "#{name} не является классом #{args[0]}" if arg == :type && !arg.instance_of?(args[0])
    end
  end

  module InstanceMethods
    def valid?(name_arg, form_arg, *arg)
      validate!(name_arg, form_arg, *arg)
    end

    def validate!(name_arg, form_arg, *arg)
      self.class.validate(name_arg, form_arg, *arg)
    rescue TypeError => e
      puts "Возникла ошибка #{e.class}: #{e.message}"
      false
    else
      true
    end
  end
end
