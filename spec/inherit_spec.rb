require File.join( File.dirname(__FILE__), "spec_helper" )

describe DslAccessor do
  #        | foo | bar | baz | qux | quux |
  # Bottom |  *  |  *  |  o  |  o  |      |
  # Middle |     |  o  |     |  +  |   o  |
  # Top    |  +  |     |  +  |  o  |   o  |
  #
  # *) dsl_accessor :foo
  # o) dsl_accessor :foo, 'val'
  # +) foo 'val'

  class Bottom
    dsl_accessor :foo
    dsl_accessor :bar
    dsl_accessor :baz, 'baz1'
    dsl_accessor :qux, 'qux1'
  end

  class Middle < Bottom
    dsl_accessor :bar, 'bar2'
    qux 'qux2'
    dsl_accessor :quux, 'quux2'
  end

  class Top < Middle
    foo 'foo3'
    baz 'baz3'
    dsl_accessor :qux , 'qux3'
    dsl_accessor :quux, 'quux3'
  end

  it "should define accessor methods" do
    Bottom.foo.should == nil
    Bottom.bar.should == nil
    Bottom.baz.should == 'baz1'
    Bottom.qux.should == 'qux1'
    lambda { Bottom.quux }.should raise_error(NameError)
  end

  it "should inherit value" do
    Middle.foo.should == nil
    Middle.bar.should == 'bar2'
    Middle.baz.should == 'baz1'
    Middle.qux.should == 'qux2'
    Middle.quux.should == 'quux2'
  end
end
