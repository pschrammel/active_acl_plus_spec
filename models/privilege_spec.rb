require File.dirname(__FILE__) + '/../spec_helper'

describe ActiveAcl::Privilege do
  before :all do
    test=ActiveAcl::Privilege.find_by_section_and_value('Forum', 'TEST')
    test.delete if test
  end
  after :all do
    test=ActiveAcl::Privilege.find_by_section_and_value('Forum', 'TEST')
    test.delete if test
  end
  
  it "set_privilege_const should create the privilege" do
    ActiveAcl::Privilege.find_by_section_and_value('Forum', 'TEST').should == nil
    Forum.privilege_const_set('TEST', true)
    priv=ActiveAcl::Privilege.find_by_section_and_value('Forum', 'TEST')
    priv.section.should == 'Forum'
    priv.value.should == 'TEST'
  end
  
  it "should have the description set"
end