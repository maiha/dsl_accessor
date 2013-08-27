require 'optionize'

module DslAccessor
  def dsl_accessor_reader(key, *args, &block)
    key = key.to_s
    if !args.empty? or block_given?
      # setter method
      dsl_accessor_writer(key, *args, &block)
    else
      # getter method
      if !dsl_accessor_key?(key)
        # load default value
        default = dsl_accessor_get("#{key}_default")
        value   = default ? instance_eval(&default) : nil
        dsl_accessor_writer(key, value)
      end
      dsl_accessor_get(key)
    end
  end

  def dsl_accessor_writer(key, *args, &block)
    case args.size
    when 0
      unless block_given?
        raise ArgumentError, "'#{key}=' expected one argument or block, but nothing passed"
      end
      writer = dsl_accessor_get("#{key}_writer")
      value  = writer ? writer.call(block) : block
      dsl_accessor_set("#{key}", value)
    when 1
      if block_given?
        raise ArgumentError, "'#{key}=' got both arg and block, specify only one of them"
      end

      writer = dsl_accessor_get("#{key}_writer")
      value  = writer ? writer.call(*args) : args.first
      dsl_accessor_set("#{key}", value)
    else
      raise ArgumentError, "'#{key}=' expected one argument, but got #{args.size} args"
    end
  end

  def dsl_accessor(*args, &block)
    opts = Optionize.new(args, :name, :default)
    name = opts.name

    if block
      case name
      when :class, NilClass
        AutoDeclare::DefineClassMethod.new(self, &block)
      when :instance
        AutoDeclare::DefineInstanceMethod.new(self, &block)
      else
        raise ArgumentError, "dsl_accessor block expects :class or :instance for arg, but got #{name.inspect}"
      end
      return
    end

    if !name
      raise ArgumentError, "dsl_accessor expects at least one arg"
    end

    writer =
      case opts.writer
      when NilClass then Proc.new{|value| value}
      when Symbol   then Proc.new{|value| __send__(opts.writer, value)}
      when Proc     then opts.writer
      else raise TypeError, "DSL Error: writer should be a symbol or proc. but got `#{opts.writer.class}'"
      end
    dsl_accessor_set("#{name}_writer", writer)

    default =
      case opts.default
      when NilClass then nil
      when []       then Proc.new{[]}
      when {}       then Proc.new{{}}
      when Symbol   then Proc.new{__send__(opts.default)}
      when Proc     then opts.default
      else Proc.new{opts.default}
      end
    dsl_accessor_set("#{name}_default", default)

    meta_class = (class << self; self; end)

    if opts.instance and !is_a?(Class)
      raise ArgumentError, ":instance option is implemented in only Class"
    end

    case opts.instance
    when nil
      # nop
    when true
      delegate name, :to=>"self.class"
    when Symbol
      module_eval(<<-EOS, "(__DSL_ACCESSOR__)", 1)
        def #{ name }
          @#{opts.instance} or
            raise TypeError, "DSL Error: missing @#{opts.instance} for %s##{name}" % self.class.name
          @#{opts.instance}.respond_to?(:[]) or
            raise TypeError, "DSL Error: expected @#{opts.instance}[] is implemented (%s##{name})" % self.class.name
          @#{opts.instance}[:#{ name }] || self.class.#{ name }
        end
      EOS
    else
      raise TypeError, "DSL Error: :instance should be true or Symbol, but got `%s' class" % opts.instance.class
    end

    instance_eval <<-EOS
      def #{name}(*args, &block)
        dsl_accessor_reader("#{name}", *args, &block)
      end
      def #{name}=(*args, &block)
        dsl_accessor_writer("#{name}", *args, &block)
      end
    EOS
  end
end
