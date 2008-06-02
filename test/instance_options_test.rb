require File.dirname(__FILE__) + '/test_helper'

class DefineInstanceMethodWithOptionsTest < Test::Unit::TestCase
  class Window
    dsl_accessor :width, :default=>640, :instance=>:options
  end

  class OptionedWindow
    dsl_accessor :width, :default=>640, :instance=>:options
    def initialize(options = {})
      @options = options
    end
  end

  def test_class_method
    assert_equal Window.width, 640
    assert_equal OptionedWindow.width, 640
  end

  def test_instance_method
    assert_raises(TypeError) { Window.new.width }
    assert_equal OptionedWindow.new.width, 640
  end

  def test_use_options_variable_rather_than_default_value
    window = OptionedWindow.new( :width => 320 )
    assert_equal window.width, 320
  end

  def test_instance_options_value_doesnt_affect_to_class_method
    window = OptionedWindow.new( :width => 320 )
    assert_equal OptionedWindow.width, 640
  end

end



