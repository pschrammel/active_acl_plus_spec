require File.dirname(__FILE__) + '/../spec_helper'

describe "has_privilege ungrouped - grouped" do
  before do
    User.delete_all
    UserGroup.delete_all
    Company.delete_all
    ActiveAcl::Acl.delete_all
    # ActiveAcl::Privilege.delete_all very bad idea!
    ActiveAcl::RequesterLink.delete_all
    ActiveAcl::RequesterGroupLink.delete_all
    ActiveAcl::TargetLink.delete_all
    ActiveAcl::TargetGroupLink.delete_all
    
    @company=Company.create!(:name => 'gaagle')
  end
  # o (2d object)
  # o-o (3d object)
  # g (2d object group)
  # g-g (3d object group) .....
  
  #tests for a 2d privilege on a grouped object
  describe "with 2d" do
    it "should have the o privilege" do
      @company.has_privilege?(Company::POST_AD).should == false
      acl=@company.grant_privilege!(Company::POST_AD)
      @company.has_privilege?(Company::POST_AD).should == true
    end
  end
  
    
end
