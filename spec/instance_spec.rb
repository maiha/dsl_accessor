require File.join( File.dirname(__FILE__), "spec_helper" )

describe "dsl_accessor(:foo, :instance=>true)" do
  before do
    klass = Class.new
    klass.dsl_accessor :foo, :instance=>true
    @klass = klass
  end

  it "should provide instance method 'foo'" do
    @klass.new.should respond_to(:foo)
  end

  it "should delegate instance method to class method about reader" do
    @klass.foo 1
    @klass.new.foo.should == 1
  end
end

describe "dsl_accessor(:foo, :instance=>:opts)" do
  before do
    klass = Class.new
    klass.dsl_accessor :foo, :instance=>:opts
    @klass = klass
    @obj = @klass.new
  end

  it "should raise error when @opts is not set" do
    lambda {
      @obj.foo
    }.should raise_error(/missing @opts/)
  end

  it "should raise error when @opts is present but not responds to []" do
    @obj.instance_eval "@opts = true"
    lambda {
      @obj.foo
    }.should raise_error(/expected @opts\[\]/)
  end

  it "should read value from @opts first" do
    @obj.instance_eval "@opts = {:foo=>2}"
    @obj.foo.should == 2
  end

  it "should read value from class when @opts value is blank" do
    @klass.foo 1
    @obj.instance_eval "@opts = {}"
    @obj.foo.should == 1
  end
end
