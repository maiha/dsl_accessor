require File.dirname(__FILE__) + '/test_helper'


class DslWriterAccessorTest < Test::Unit::TestCase
  class Item
    dsl_accessor :primary_key, :writer=>proc{|value| value.to_s}
  end

  def test_string_writer
    assert_equal "", Item.primary_key

    Item.primary_key :id
    assert_equal "id", Item.primary_key

    Item.primary_key "id"
    assert_equal "id", Item.primary_key
  end
end



