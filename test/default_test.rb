require File.dirname(__FILE__) + '/test_helper'


class DslDefaultAccessorTest < Test::Unit::TestCase

  class CoolActiveRecord
    dsl_accessor :primary_key, :default=>"id"
    dsl_accessor :table_name,  :default=>proc{|klass| klass.name.split(/::/).last.downcase+"s"}
  end

  class Item < CoolActiveRecord
  end

  class User < CoolActiveRecord
  end

  class Folder
    dsl_accessor :array_folder, :default=>[]
    dsl_accessor :hash_folder,  :default=>{}
  end

  class SubFolder < Folder
  end

  def test_default_accessor_with_string
    assert_equal "id", Item.primary_key
    assert_equal "id", User.primary_key
  end

  def test_default_accessor_with_proc
    assert_equal "items", Item.table_name
    assert_equal "users", User.table_name
  end

  def test_default_accessor_should_duplicate_empty_array_or_hash
    Folder.array_folder << 1
    Folder.hash_folder[:name] = "maiha"

    assert_equal([1], Folder.array_folder)
    assert_equal({:name=>"maiha"}, Folder.hash_folder)

    assert_equal([], SubFolder.array_folder)
    assert_equal({}, SubFolder.hash_folder)
  end
end


class DslOverwritenDefaultAccessorTest < Test::Unit::TestCase
  class CoolActiveRecord
    dsl_accessor :primary_key, :default=>"id"
    dsl_accessor :table_name,  :default=>proc{|klass| klass.name+"s"}
  end

  class Item < CoolActiveRecord
    primary_key :item_id
    table_name  :item_table
  end

  def test_overwrite_default_accessor
    assert_equal :item_id,    Item.primary_key
    assert_equal :item_table, Item.table_name
  end
end

