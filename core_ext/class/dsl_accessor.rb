unless Class.new.respond_to?(:class_inheritable_accessor)
  require File.dirname(__FILE__) + "/../duplicable" unless Object.new.respond_to?(:duplicable?)
  require File.dirname(__FILE__) + "/inheritable_attributes"
end

module DslAccessor
  def dsl_accessor(*args)
    options = args.last.is_a?(Hash) ? args.pop : {}

    # mark auto_declared
    name = args.shift or
      return @dsl_accessor_auto_declared = true

    options[:default] = args.shift unless args.empty?

    case options[:instance]
    when nil
      # nop
    when :options
      module_eval(<<-EOS, "(__DSL_ACCESSOR__)", 1)
        def #{ name }
          unless @options
            raise TypeError, "DSL Error: missing @options for %s##{name}" % self.class.name
          end
          @options[:#{ name }] || self.class.#{ name }
        end
      EOS
    when true
      delegate name, :to=>"self.class"
    else
      raise TypeError, "DSL Error: :instance should be true or :instance, but got `%s' class" % options[:instance].class
    end

    raise TypeError, "DSL Error: options should be a hash. but got `#{options.class}'" unless options.is_a?(Hash)
    writer = options[:writer] || options[:setter]
    writer =
      case writer
      when NilClass then Proc.new{|value| value}
      when Symbol   then Proc.new{|value| __send__(writer, value)}
      when Proc     then writer
      else raise TypeError, "DSL Error: writer should be a symbol or proc. but got `#{options[:writer].class}'"
      end
    write_inheritable_attribute(:"#{name}_writer", writer)

    default =
      case options[:default]
      when NilClass then nil
      when []       then Proc.new{[]}
      when {}       then Proc.new{{}}
      when Symbol   then Proc.new{__send__(options[:default])}
      when Proc     then options[:default]
      else Proc.new{options[:default]}
      end
    write_inheritable_attribute(:"#{name}_default", default)

    (class << self; self end).class_eval do
      define_method("#{name}=") do |value|
        writer = read_inheritable_attribute(:"#{name}_writer")
        value  = writer.call(value) if writer
        write_inheritable_attribute(:"#{name}", value)
      end

      define_method(name) do |*values|
        if values.empty?
          # getter method
          key = :"#{name}"
          if !inheritable_attributes.has_key?(key)
            default = read_inheritable_attribute(:"#{name}_default")
            value   = default ? default.call(self) : nil
            __send__("#{name}=", value)
          end
          read_inheritable_attribute(key)
        else
          # setter method
          __send__("#{name}=", *values)
        end
      end
    end
  end

  private
    def dsl_accessor_auto_declared?
      !!@dsl_accessor_auto_declared
    end

    def method_missing(*args, &block)
      if dsl_accessor_auto_declared? and args.size == 1 and block
        define_method(*args, &block)
      else
        super
      end
    end

end

class Class
  include DslAccessor
end
