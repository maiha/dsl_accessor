require File.join( File.dirname(__FILE__), "spec_helper" )

describe DslAccessor do
  it "class should provide 'dsl_accessor'" do
    Class.new.should respond_to(:dsl_accessor)
  end
end

describe "dsl_accessor(:foo)" do
  before do
    @klass = new_class { dsl_accessor :foo }
  end

  it "should provide 'foo' method" do
    @klass.should respond_to(:foo)
  end

  it "should accept nil for default value" do
    @klass.foo.should == nil
  end

  it "should provide 'foo=' method" do
    @klass.should respond_to(:foo=)
  end

  it "#foo= should raise ArgumentError" do
    lambda { @klass.send(:foo=) }.should raise_error(ArgumentError)
  end

  it "#foo=(1) should not raise ArgumentError" do
    lambda { @klass.foo = 1 }.should_not raise_error(ArgumentError)
  end

  it "#foo=(1) should set :foo to 1" do
    @klass.foo = 1
    @klass.foo.should == 1
  end

  it "#foo=(1, 2) should raise ArgumentError" do
    lambda { @klass.send(:foo=,1,2) }.should raise_error(ArgumentError)
  end
end

describe "dsl_accessor(:foo, 1)" do
  before do
    @klass = new_class { dsl_accessor :foo, 1 }
  end

  it "should provide 'foo' method" do
    @klass.should respond_to(:foo)
  end

  it "should accept 1 for default value" do
    @klass.foo.should == 1
  end
end
