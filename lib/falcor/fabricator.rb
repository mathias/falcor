require 'active_support/core_ext'

module Falcor
  class Fabricator
    class << self
      attr_accessor :factories

      def define(name, options = {}, &block)
        factories[name] = self.new({ :name => name, :block => block }.merge(options))
      end

      def create(name, overrides, block)
        raise "No factory defined: [#{name}]" unless factories.has_key?(name)

        factories[name].create(overrides)
      end
    end

    def create(overrides)
      @options = @definition.merge(overrides)
      @options[:super] = Factory if @options[:super].nil?
      klass = create_class
      klass.create_methods(@options[:block])

      klass.new(overrides)
    end

  private

    def initialize(options)
      @definition = options
    end

    def create_class
      Object.send(:remove_const, class_name) rescue nil
      klass = Object.const_set class_name, Class.new(@options[:super])

      klass
    end

    def class_name
      (@options[:class] || @options[:name]).to_s.camelize
    end

    self.factories = {}
  end
end
