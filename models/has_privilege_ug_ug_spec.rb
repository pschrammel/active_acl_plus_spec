require File.dirname(__FILE__) + '/../spec_helper'

# these spec are for ungrouped requesters and targets
describe "has_privilege ungrouped - ungrouped" do
  before do
    Company.delete_all
    Page.delete_all
    ActiveAcl::Acl.delete_all
    # ActiveAcl::Privilege.delete_all very bad idea!
    ActiveAcl::RequesterLink.delete_all
    ActiveAcl::RequesterGroupLink.delete_all
    ActiveAcl::TargetLink.delete_all
    ActiveAcl::TargetGroupLink.delete_all
    
    @company=Company.create!(:name => 'gaagle')
    @page=Page.create!(:title => 'Start') 
  end
  # o (2d object)
  # o-o (3d object)
  
  it "should have the o privilege" do
    @company.has_privilege?(Company::POST_AD).should == false
    acl=@company.grant_privilege!(Company::POST_AD)
    
    @company.has_privilege?(Company::POST_AD).should == true
  end
  
  
  it "should have the o-o privilege" do
    @company.has_privilege?(Page::VIEW,:on=> @page).should == false
    acl=@company.grant_privilege!(Page::VIEW,:on => @page)
    @company.has_privilege?(Page::VIEW,:on => @page).should == true
  end

end
