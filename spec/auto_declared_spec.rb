require File.join( File.dirname(__FILE__), "spec_helper" )

describe DslAccessor do
  before(:each) do
    Object.send(:remove_const, :Foo) if Object.const_defined?(:Foo)
    class Foo
    end
  end

  def foo_should_not_be_defined
    Foo    .should_not respond_to(:foo)
    Foo.new.should_not respond_to(:foo)
  end

  it "should provide .dsl_accessor_auto_declared as private method" do
    Class.private_methods.should include("dsl_accessor_auto_declared?")
  end

  it "should provide .dsl_accessor" do
    Class.should respond_to(:dsl_accessor)
  end

  describe " should raise NoMethodError when we call a method " do
    it "without arugments" do
      foo_should_not_be_defined
      lambda { Foo.foo }.should raise_error(NoMethodError)
      foo_should_not_be_defined
    end
    it "with arguments" do
      foo_should_not_be_defined
      lambda { Foo.foo(1) }.should raise_error(NoMethodError)
      lambda { Foo.foo(1, 2) }.should raise_error(NoMethodError)
      foo_should_not_be_defined
    end
    it "with block" do
      foo_should_not_be_defined
      lambda { Foo.foo{} }.should raise_error(NoMethodError)
      foo_should_not_be_defined
    end
    it "with arguments and block" do
      foo_should_not_be_defined
      lambda { Foo.foo(1){} }.should raise_error(NoMethodError)
      foo_should_not_be_defined
    end
  end

  describe ".dsl_accessor without arguments" do
    it "should be accepted" do
      lambda {
        Foo.dsl_accessor
      }.should_not raise_error
    end

    it "should mark auto_declared" do
      Foo.send(:dsl_accessor_auto_declared?).should be_false
      Foo.dsl_accessor
      Foo.send(:dsl_accessor_auto_declared?).should be_true
    end
  end

  describe "auto_declared" do
    before(:each) do
      class Foo
        dsl_accessor
      end
    end

    it "should raise NoMethodError if unknown method with args is called" do
      lambda {
        Foo.foo(1)
      }.should raise_error(NoMethodError)
    end

    it "should raise NoMethodError when unknown method is called with args and block" do
      lambda {
        Foo.foo(1){}
      }.should raise_error(NoMethodError)
    end

    describe " when unknown method is called with a block" do
      it "should trap NoMethodError" do
        lambda {
          Foo.foo{}
        }.should_not raise_error(NoMethodError)
      end

      it "should define its instance method automatically" do
        foo_should_not_be_defined
        Foo.foo{1}
        Foo.new.should respond_to(:foo)
        Foo.new.foo.should == 1
      end
    end

    it "should affect nothing to subclasses" do
      class Bar < Foo
      end

      lambda { Bar.bar       }.should raise_error(NoMethodError)
      lambda { Bar.bar(1)    }.should raise_error(NoMethodError)
      lambda { Bar.bar(1, 2) }.should raise_error(NoMethodError)
      lambda { Bar.bar{}     }.should raise_error(NoMethodError)
      lambda { Bar.bar(1){}  }.should raise_error(NoMethodError)
    end
  end
end
