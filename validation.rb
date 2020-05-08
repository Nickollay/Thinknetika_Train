# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, *arg)
      @validate ||= []
      @validate << { name: name, type: type, arg: arg }
    end
  end

  module InstanceMethods
    def valid?
      validate! ? true : false
    end

    private

    def validate!
      self.class.instance_variable_get('@validate').each do |hash|
        name = hash[:name]
        value = instance_variable_get("@#{name}")
        arg = hash[:arg][0]
        type = hash[:type]
        send "validate_#{type}", name, value, arg
      end
    end

    def validate_presence(name, value, _)
      raise "#{name} should be present." if value.nil? || value.empty?
    end

    def validate_format(name, value, regex)
      raise "Format of #{name} should be #{regex}" if value !~ regex
    end

    def validate_type(name, value, type)
      raise "#{name}: #{value} should be #{type}." if value.class != type
    end

    def validate_positive(name, value, _)
      raise "#{name}: #{value} should be positive." unless value.positive?
    end

    def validate_length(name, value, arg)
      raise "Length of #{name} should be at least #{arg}!" if value.length < arg
    end
  end
end
