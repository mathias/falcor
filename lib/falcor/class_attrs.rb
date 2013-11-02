module Falcor
  module ClassAttrs
    class << self
      def included(base)
        base.extend ClassMethods
      end
    end

    module ClassMethods
      def class_attr(attr_name)
        (class << self; self; end).instance_eval {
          define_method attr_name.intern do
            instance_variable_get("@#{attr_name}")
          end

          define_method "#{attr_name}=".intern do |val|
            instance_variable_set("@#{attr_name}", val)
          end
        }
      end
    end
  end
end

