require "rubygems"
require "spec"

require File.dirname(__FILE__) + "/../init"

######################################################################
### Helper methods

def new_class(&block)
  Class.new(&block)
end
