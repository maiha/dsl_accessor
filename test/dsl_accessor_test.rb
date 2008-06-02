require File.dirname(__FILE__) + '/test_helper'


class DslAccessorTest < Test::Unit::TestCase
  class CoolActiveRecord
    dsl_accessor :primary_key
    dsl_accessor :table_name
  end

  class Item < CoolActiveRecord
  end

  class LegacyItem < CoolActiveRecord
    primary_key :itcd
    table_name  :item
  end

  class OtherClass
  end

  def test_dsl_accessor_doesnt_affect_other_classes
    assert !OtherClass.respond_to?(:primary_key)
  end

  def test_accessor_without_initialization
    assert_equal nil, Item.primary_key
    assert_equal nil, Item.table_name

    Item.primary_key :itcd
    Item.table_name  :item

    assert_equal :itcd, Item.primary_key
    assert_equal :item, Item.table_name
  end

  def test_accessor_with_initialization
    assert_equal :itcd, LegacyItem.primary_key
    assert_equal :item, LegacyItem.table_name

    LegacyItem.primary_key :item_id
    LegacyItem.table_name  :item_table

    assert_equal :item_id,    LegacyItem.primary_key
    assert_equal :item_table, LegacyItem.table_name
  end
end

