unless Class.new.respond_to?(:write_inheritable_attribute)
  require File.dirname(__FILE__) + "/../core_ext/duplicable" unless Object.new.respond_to?(:duplicable?)
  require File.dirname(__FILE__) + "/../core_ext/class/inheritable_attributes"
end

unless Module.new.respond_to?(:delegate)
  require File.dirname(__FILE__) + "/../core_ext/module/delegation"
end

require File.dirname(__FILE__) + '/../core_ext/class/dsl_accessor'

