require File.join( File.dirname(__FILE__), "spec_helper" )

describe DslAccessor do
  before do
    Object.send(:remove_const, :Foo) if Object.const_defined?(:Foo)
    Foo = Class.new
  end

  def dsl_accessor(*args, &block)
    Foo.dsl_accessor(*args, &block)
  end

  ######################################################################
  ### Class Methods

  describe "dsl_accessor(&block)" do
    context " should raise NameError when" do
      def dsl_accessor(*args, &block)
        lambda { super }.should raise_error(NameError)
      end

      it "foo" do
        dsl_accessor { foo }
      end

      it "foo(1)" do
        dsl_accessor { foo(1) }
      end

      it "foo(1,2)" do
        dsl_accessor { foo(1,2) }
      end

      it "foo(1) {}" do
        dsl_accessor { foo(1) {} }
      end
    end

    context " should define class method 'foo' when" do
      def dsl_accessor(*args, &block)
        super
        Foo.should respond_to(:foo)
      end

      it "foo {}" do
        dsl_accessor { foo {} }
      end
    end

    it "should overwrite existing class methods such as 'name'" do
      Foo.dsl_accessor {
        name { 1 }
      }
      Foo.name.should == 1
    end

    it "should invoke the method in valid context" do
      Foo.should_receive(:bar) { 2 }
      dsl_accessor { foo { bar } }
      Foo.foo.should == 2
    end
  end

  ######################################################################
  ### Instance Methods

  describe "dsl_accessor(:instance, &block)" do
    context " should raise NameError when" do
      def dsl_accessor(*args, &block)
        lambda { super }.should raise_error(NameError)
      end

      it "foo" do
        dsl_accessor(:instance) { foo }
      end

      it "foo(1)" do
        dsl_accessor(:instance) { foo(1) }
      end

      it "foo(1,2)" do
        dsl_accessor(:instance) { foo(1,2) }
      end

      it "foo(1) {}" do
        dsl_accessor(:instance) { foo(1) {} }
      end
    end

    context " should define instance method 'foo' when" do
      def dsl_accessor(*args, &block)
        super
        Foo.new.should respond_to(:foo)
      end

      it "foo {}" do
        dsl_accessor(:instance) { foo {} }
      end
    end

    it "should define instance method" do
      Foo.dsl_accessor(:instance) {
        foo { 'xxx' }
      }
      Foo.new.foo.should == 'xxx'
    end

    it "should orverwrite existed instance methods even if those are important like 'id'" do
      Foo.new.object_id.should be_kind_of(Integer)
      Foo.dsl_accessor(:instance) {
        id { 'xxx' }
      }
      Foo.new.id.should == 'xxx'
    end

    it "should invoke the method in valid context" do
      Foo.any_instance.should_receive(:bar) { 2 }
      dsl_accessor(:instance) { foo { bar } }
      Foo.new.foo.should == 2
    end
  end
end

