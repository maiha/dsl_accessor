require File.dirname(__FILE__) + '/test_helper'

class DefineInstanceMethodTest < Test::Unit::TestCase
  class Item
    dsl_accessor :primary_key, "code", :instance=>true
  end

  class OtherClass
  end

  def test_dsl_accessor_doesnt_affect_other_classes
    assert !OtherClass.respond_to?(:primary_key)
  end

  def test_dsl_accessor_doesnt_affect_other_instances
    assert !OtherClass.new.respond_to?(:primary_key)
  end

  def test_class_method
    assert Item.respond_to?(:primary_key)
    assert_nothing_raised do
      Item.primary_key
    end
  end

  def test_class_method_value
    assert_equal "code", Item.primary_key
  end

  def test_instance_method
    assert Item.new.respond_to?(:primary_key)
    assert_nothing_raised do
      Item.new.primary_key
    end
  end

  def test_instance_method_value
    assert_equal "code", Item.new.primary_key
  end
end



