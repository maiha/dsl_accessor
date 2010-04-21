require 'blankslate'

module DslAccessor
  module AutoDeclare
    class DefineClassMethod < BlankSlate
      def initialize(context, &block)
        @context = context
        instance_eval(&block)
      end

      private
        def method_missing(name, *args, &block)
          if args.empty? and block
            meta_class = (class << @context; self; end)
            meta_class.class_eval{ define_method(name, &block) }
          else
            @context.__send__(name, *args, &block)
          end
        end
    end

    class DefineInstanceMethod < BlankSlate
      def initialize(klass, &block)
        @klass = klass
        instance_eval(&block)
      end

      private
        def method_missing(name, *args, &block)
          if args.empty? and block
            @klass.class_eval{ define_method(name, &block) }
          else
            raise NameError, "undefined local variable or method `#{name}'"
          end
        end
    end
  end
end


__END__
