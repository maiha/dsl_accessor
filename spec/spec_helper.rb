require "rubygems"
require "rspec"

require File.dirname(__FILE__) + "/../lib/dsl_accessor"

######################################################################
### Helper methods

def new_class(&block)
  Class.new(&block)
end
