require File.dirname(__FILE__) + '/../spec_helper'

describe "has_privilege ungrouped - grouped" do
  before do
    User.delete_all
    UserGroup.delete_all
    ActiveAcl::Acl.delete_all
    # ActiveAcl::Privilege.delete_all very bad idea!
    ActiveAcl::RequesterLink.delete_all
    ActiveAcl::RequesterGroupLink.delete_all
    ActiveAcl::TargetLink.delete_all
    ActiveAcl::TargetGroupLink.delete_all
    
    @user=User.create!(:login => 'user1')
    @root_group = UserGroup.create!(:description => 'root')
    @users = UserGroup.create!(:description => 'users')
    @users.move_to_child_of(@root_group)
    @users.users << @user 
  end
  # o (2d object)
  # o-o (3d object)
  # g (2d object group)
  # g-g (3d object group) .....
  
  #tests for a 2d privilege on a grouped object
  describe "with 2d" do
    it "should have the o privilege" do
      @user.has_privilege?(User::LOGIN).should == false
      acl=@user.grant_permission!(User::LOGIN)
      @user.has_privilege?(User::LOGIN).should == true
    end
    
    it "should have the g privilege"
    
    it "should have the g(hbtm) privilege" do
      @user.has_privilege?(User::LOGIN).should == false
      acl=@users.grant_permission!(User::LOGIN)
      @user.active_acl_clear_cache! #the group knows nothing 
      #about the instances so we have to do this by hand 
      @user.has_privilege?(User::LOGIN).should == true
    end
  end
end