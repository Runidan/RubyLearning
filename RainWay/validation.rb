# frozen_string_literal: true

module Validation
  def validate

    define_method("valid?") do |name_arg, form_arg, *args|
      return true if validate!(name_arg, form_arg, *args)
      false
    end

    define_method("validate!") do |name, type, *args|
      raise RailRoadExeption, "#{name}  is not symbol" unless name.is_a?(Symbol)
      raise RailRoadExeption, "#{type}  is not symbol" unless type.is_a?(Symbol)
      raise RailRoadExeption, "#{type}  может быть только :presence, :format или :type" unless %i[presence format
                                                                                          type].include?(type)

      arg = instance_variable_get("@#{name}")
      raise RailRoadExeption, "#{name} не может быть пустым" if type == :presence && (arg.nil? || arg.empty?)

      if type == :format && !args[0].instance_of?(Regexp)
        raise RailRoadExeption,
              "#{args[0]} не является регулярным выражением"
      end
      raise RailRoadExeption, "#{name} не соответствует регулярному выражению" if type == :format && !arg.match?(args[0])

      if type == :type && !args[0].class.instance_of?(Class)
        raise RailRoadExeption,
              "#{args[0]} не является классом (третий аргумент)"
      end
      raise RailRoadExeption, "#{name} не является классом #{args[0]}" if arg == :type && !arg.instance_of?(args[0])

      true
    end
  end
end
