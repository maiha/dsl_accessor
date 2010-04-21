require "rubygems"
require "spec"
require "rr"

require File.dirname(__FILE__) + "/../lib/dsl_accessor"

Spec::Runner.configure do |config|
  config.mock_with RR::Adapters::Rspec
end

######################################################################
### Helper methods

def new_class(&block)
  Class.new(&block)
end
