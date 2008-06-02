require 'test/unit'

def __DIR__; File.dirname(__FILE__); end

begin
  require 'rubygems'
  require 'active_support'
rescue LoadError
  $:.unshift(__DIR__ + '/../../../rails/activesupport/lib')
  require 'active_support'
end

require File.dirname(__FILE__) + '/../init'

