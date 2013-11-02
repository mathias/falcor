module Falcor
  class Factory
    include ClassAttrs
    include DefineDsl

    class_attr :fields
    class_attr :lists
    class_attr :associations

    class << self
      def create_methods(blk)
        instance_eval(&blk)
      end
    end

    def initialize(overrides)
      unless overrides.empty?
        overrides.each do |k,v|
          self.send(:"#{k}=", v)
        end
      end
    end

    def fields
      self.class.fields || []
    end

    def associations
      self.class.associations || []
    end

    def lists
      self.class.lists || []
    end

    def to_json
      json = {}

      fields.each do |field|
        value = self.send(field)
        unless value.nil?
          json[field.to_s] = self.send(field)
        end
      end

      associations.each do |field|
        json[field.to_js] = self.send(field).send(:to_json)
      end

      lists.each do |field|
        json[field.to_s] = self.send(field).map { |m| m.to_json }
      end

      json
    end
  end
end

