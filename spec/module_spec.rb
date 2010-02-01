require File.join( File.dirname(__FILE__), "spec_helper" )

describe Module do
  it "should provide 'dsl_accessor'" do
    Module.new.should respond_to(:dsl_accessor)
  end

  describe "#dsl_accessor(:foo, 1)" do
    subject { 
      mod = Module.new
      mod.dsl_accessor :foo, 1
      mod
    }
    # default value
    its(:foo) { should == 1}

    it "foo(2) should update value to 2" do
      subject.foo 2
      subject.foo.should == 2
    end
  end
end
