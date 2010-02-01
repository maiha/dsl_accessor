unless Module.new.respond_to?(:delegate)
  require File.dirname(__FILE__) + "/../core_ext/module/delegation"
end

require File.dirname(__FILE__) + '/dsl_accessor/accessor'
require File.dirname(__FILE__) + '/dsl_accessor/stores'

class Module
  include DslAccessor
  include DslAccessor::Stores::Basic
end

class Class
  include DslAccessor
  include DslAccessor::Stores::Inherit
end

