require File.dirname(__FILE__) + '/../spec_helper'

describe "ActiveAcl::Base" do
  it "should be acces_object" do
    ActiveAcl.is_access_object?(User).should == true
    ActiveAcl.is_access_object?(UserGroup).should == false
  end
  it "should be acces_group" do
    ActiveAcl.is_access_group?(UserGroup).should == true
    ActiveAcl.is_access_group?(User).should == false
  end
end
