# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*methods)
    methods.each do |method|
      raise TypeError.new('Method name is not symbol.') unless method.is_a?(Symbol)

      define_method(method) { instance_variable_get("@#{method}") }
      define_method("#{method}_history") { instance_variable_get("@#{method}_history") }

      define_method("#{method}=") do |value|
        instance_variable_set("@#{method}", value)
        instance_variable_set("@#{method}_history", []) if instance_variable_get("@#{method}_history").nil?
        instance_variable_get("@#{method}_history") << value
      end
    end
  end

  def strong_attr_accessor(method, method_class)
      raise TypeError.new('Method name is not symbol.') unless method.is_a?(Symbol)
      define_method(method) { instance_variable_get("@#{method}") }

      define_method("#{method}=") do |value|
        raise TypeError.new("Method type is not #{method_class}.") unless value.is_a?(method_class)
        instance_variable_set("@#{method}", value)
      end
  end
end
