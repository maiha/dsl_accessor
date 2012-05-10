require File.join( File.dirname(__FILE__), "spec_helper" )

describe "dsl_accessor :foo" do
  before do
    @klass = new_class { dsl_accessor :foo }
  end

  it "should accept foo(1)" do
    @klass.foo 1
    @klass.foo.should == 1
  end

  it "should reject foo(1, &block)" do
    lambda {
      @klass.foo(2) { 3 }
    }.should raise_error(ArgumentError)
  end

  it "should accept foo(&block)" do
    @klass.foo { 4 }
    @klass.foo.should be_kind_of(Proc)
    @klass.foo.call.should == 4
  end
end
