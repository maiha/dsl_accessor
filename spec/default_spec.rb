require File.join( File.dirname(__FILE__), "spec_helper" )

describe DslAccessor do
  it "should duplicate blank array automatically" do
    k1 = Class.new

    array = []
    k1.dsl_accessor :foo, array

    k1.foo.should == array
    k1.foo.should_not equal(array)
  end

  it "should duplicate blank hash automatically" do
    k1 = Class.new

    hash = {}
    k1.dsl_accessor :foo, :default=>hash

    k1.foo.should == hash
    k1.foo.should_not equal(hash)
  end

  it "should call the method when symbol given" do
    k1 = Class.new
    def k1.construct
      1
    end
    k1.dsl_accessor :foo, :default=>:construct

    k1.foo.should == 1
  end

  it "should call it when proc given" do
    k1 = Class.new
    k1.dsl_accessor :foo, :default=>proc{1}
    k1.foo.should == 1
  end
end
