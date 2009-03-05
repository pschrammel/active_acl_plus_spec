require File.dirname(__FILE__) + '/../spec_helper'

describe "ActiveAcl::Grant" do
  before do
    User.delete_all
    UserGroup.delete_all
    ActiveAcl::Acl.delete_all
    #ActiveAcl::Privilege.delete_all
    ActiveAcl::RequesterLink.delete_all
    ActiveAcl::RequesterGroupLink.delete_all
    ActiveAcl::TargetLink.delete_all
    ActiveAcl::TargetGroupLink.delete_all

    @user=User.create!(:login => 'user1')
    @root_group = UserGroup.create!(:description => 'root')
    @users = UserGroup.create!(:description => 'users')
    @users.move_to_child_of(@root_group)
  end
  it "should grant 2d permission to user" do
    acl=@user.grant_permission!(User::LOGIN)
    acl.requesters.should == [@user]
    acl.target_groups.should be_empty
    acl.requester_groups.should be_empty
    acl.targets.should be_empty
    acl.section.iname.should == 'generic'
    acl.section.should_not be_new_record
    acl.privileges.size.should == 1
    acl.privileges[0].section.should == 'User'
    acl.privileges[0].value.should == 'LOGIN'
  end
  it "should grant 3d permission to user on a user" do
    user2=User.create!(:login => 'user2')
    acl=@user.grant_permission!(User::BAN,:on => user2)
    acl.requesters.should == [@user]
    acl.targets.should == [user2]
    acl.target_groups.should be_empty
    acl.requester_groups.should be_empty
    acl.section.iname.should == 'generic'
  end
  
  it "should grant permission on user to group" do
    acl=@users.grant_permission!(User::BAN,:on => @user)
    acl.requesters.should be_empty
    acl.requester_groups.should == [@users]
    acl.target_groups.should be_empty
    acl.targets.should == [@user]
  end
  it "should grant permission on group to user" do
    acl=@user.grant_permission!(User::BAN,:on => @users)
    acl.requesters.should == [@user]
    acl.requester_groups.should be_empty
    acl.target_groups.should == [@users]
    acl.targets.should be_empty
  end
end
