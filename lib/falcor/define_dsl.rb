module Falcor
  module DefineDsl
    class << self
      def included(base)
        base.extend ClassMethods
      end
    end

    module ClassMethods
      def allow(attr)
        self.fields = (self.fields || []).push(attr)

        default_blk = Proc.new { return self.instance_variable_get("@#{attr}".to_sym) }
        self.send(:define_method, attr, default_blk)

        default_assignment_blk = Proc.new do |val|
          self.instance_variable_set("@#{attr}".to_sym, val)
        end

        self.send(:define_method, "#{attr}=", default_assignment_blk)
      end

      def field(attr, default)
        self.fields = (self.fields || []).push(attr)

        default_blk = Proc.new { return self.instance_variable_get("@#{attr}".to_sym) || default }
        self.send(:define_method, attr, default_blk)

        default_assignment_blk = Proc.new do |val|
          self.instance_variable_set("@#{attr}".to_sym, val)
        end

        self.send(:define_method, "#{attr}=", default_assignment_blk)
      end

      def association(attr, model)
        self.associations = (self.associations || []).push(attr)

        default_blk = Proc.new { return self.instance_variable_get("@#{attr}".to_sym) || model }
        self.send(:define_method, attr, default_blk)

        default_assignment_blk = Proc.new do |val|
          if val.class == Hash
            association = self.send(attr)
            val.each do |k,v|
              association.send(:"#{k}=", v)
            end
          else
            self.instance_variable_set("@#{attr}".to_sym, val)
          end
        end
        self.send(:define_method, "#{attr}=", default_assignment_blk)
      end

      def create_list(attr, count, model)
        self.lists = (self.lists || []).push(attr)

        models = []
        count.times do
          models << model
        end

        default_blk = Proc.new { return self.instance_variable_get("@#{attr}".to_sym) || models }
        self.send(:define_method, attr, default_blk)

        default_assignment_blk = Proc.new do |val|
          raise "Invalid association list" unless val.class == Array

          factory_name = ActiveSupport::Inflector.singularize(attr).to_sym

          overrides = val.map do |override|
            Factory(factory_name, override)
          end

          self.instance_variable_set("@#{attr}".to_sym, overrides)
        end

        self.send(:define_method, "#{attr}=", default_assignment_blk)
      end
    end
  end
end
