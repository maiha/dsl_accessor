require File.join( File.dirname(__FILE__), "spec_helper" )

describe DslAccessor do
  it "should call writer" do
    klass = new_class

    klass.dsl_accessor :key, "bar", :writer=>proc{|value| "[#{value}]"}
    klass.key.should == "[bar]"

    klass.key 'foo'
    klass.key.should == "[foo]"
  end

  it "should call writer even if no default values given" do
    klass = new_class

    klass.dsl_accessor :key, :writer=>proc{|value| "[#{value}]"}
    klass.key.should == "[]"

    klass.key 'foo'
    klass.key.should == "[foo]"
  end
end
