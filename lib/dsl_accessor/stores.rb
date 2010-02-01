module DslAccessor
  module Stores
    module Basic
      # testing
      def dsl_accessor_attributes
        @dsl_accessor_attributes ||= {}
      end

      def dsl_accessor_key?(key)
        dsl_accessor_attributes.has_key?(key)
      end

      def dsl_accessor_get(key)
        dsl_accessor_attributes[key]
      end

      def dsl_accessor_set(key, val)
        dsl_accessor_attributes[key] = val
      end
    end

    module Inherit
      # testing
      def dsl_accessor_attributes
        @dsl_accessor_attributes ||= {}
      end

      def dsl_accessor_key?(key)
        dsl_accessor_attributes.has_key?(key)
      end

      def dsl_accessor_get(key)
        if dsl_accessor_key?(key)
          dsl_accessor_attributes[key]
        else
          superclass ? superclass.dsl_accessor_get(key) : nil
        end
      end

      def dsl_accessor_set(key, val)
        dsl_accessor_attributes[key] = val
      end
    end

    module InheritableAttributes
      # testing
      def dsl_accessor_key?(key)
        inheritable_attributes.has_key?(key)
      end

      def dsl_accessor_get(key)
        read_inheritable_attribute(key)
      end

      def dsl_accessor_set(key, val)
        write_inheritable_attribute(key, val)
      end
    end
  end
end
