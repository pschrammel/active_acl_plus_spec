require File.dirname(__FILE__) + '/../spec_helper'

describe "has_privilege grouped - grouped" do
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
    
    @admin=User.create!(:login => 'admin')
    @admins = UserGroup.create!(:description => 'admins')
    @admins.move_to_child_of(@root_group)
    @admins.users << @admin
    
  end
  # o (2d object)
  # o-o (3d object)
  # g (2d object group)
  # g-g (3d object group) .....
  
  #2d privileges are already tested in g_ug
  
  it "should have the g(hbtm)-g(htbm) privilege g-on-g" do
    @admin.has_privilege?(User::BAN,:on=> @user).should == false
    acl=@admins.grant_permission!(User::BAN,:on => @users)
    @admin.active_acl_clear_cache!
    @admin.has_privilege?(User::BAN,:on => @user).should == true
  end
  it "should have the g(hbtm)-g(htbm) privilege o-on-g" do
    @admin.has_privilege?(User::BAN,:on=> @user).should == false
    acl=@admin.grant_permission!(User::BAN,:on => @users)
    @admin.has_privilege?(User::BAN,:on => @user).should == true
  end
  it "should have the g(hbtm)-g(htbm) privilege g-on-o" do
    @admin.has_privilege?(User::BAN,:on=> @user).should == false
    acl=@admins.grant_permission!(User::BAN,:on => @user)
    @admin.active_acl_clear_cache!
    @admin.has_privilege?(User::BAN,:on => @user).should == true
  end
  it "should have the g(hbtm)-g(htbm) privilege o-on-o" do
    @admin.has_privilege?(User::BAN,:on=> @user).should == false
    acl=@admin.grant_permission!(User::BAN,:on => @user)
    @admin.has_privilege?(User::BAN,:on => @user).should == true
  end

end
