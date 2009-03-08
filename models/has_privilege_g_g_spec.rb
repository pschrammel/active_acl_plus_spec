require File.dirname(__FILE__) + '/../spec_helper'

describe "3d privileges (grouped - grouped)" do
  before do
    ActiveAcl::Acl.delete_all
    # ActiveAcl::Privilege.delete_all very bad idea!
    ActiveAcl::RequesterLink.delete_all
    ActiveAcl::RequesterGroupLink.delete_all
    ActiveAcl::TargetLink.delete_all
    ActiveAcl::TargetGroupLink.delete_all
    
  end
  # o (2d object)
  # o-o (3d object)
  # g (2d object group)
  # g-g (3d object group) .....
  
  #2d privileges are already tested in g_ug
  describe "with habtm - habtm" do
    before do
      User.delete_all
      UserGroup.delete_all
      
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
  

  describe "with has_many - habtm" do
    before do
      User.delete_all
      UserGroup.delete_all
      
      @user=User.create!(:login => 'user1')
      @root_group = UserGroup.create!(:description => 'root')
      @users = UserGroup.create!(:description => 'users')
      @users.move_to_child_of(@root_group)
      @users.users << @user 
      
      Person.delete_all
      Family.delete_all
      @root_family = Family.create!(:name => 'The Frankensteins')
      @monsters = Family.create!(:name => 'Monsters')
      @monsters.move_to_child_of(@root_family)
      @person=@monsters.people.create(:name => 'person1')

    end
    it "should have the g(hbtm)-g(htbm) privilege g-on-g" do
      @person.has_privilege?(User::BAN,:on=> @user).should == false
      acl=@monsters.grant_permission!(User::BAN,:on => @users)
      @person.active_acl_clear_cache!
      @person.has_privilege?(User::BAN,:on => @user).should == true
    end
    it "should have the g(hbtm)-g(htbm) privilege o-on-g" do
      @person.has_privilege?(User::BAN,:on=> @user).should == false
      acl=@person.grant_permission!(User::BAN,:on => @users)
      @person.has_privilege?(User::BAN,:on => @user).should == true
    end
    it "should have the g(hbtm)-g(htbm) privilege g-on-o" do
      @person.has_privilege?(User::BAN,:on=> @user).should == false
      acl=@monsters.grant_permission!(User::BAN,:on => @user)
      @person.active_acl_clear_cache!
      @person.has_privilege?(User::BAN,:on => @user).should == true
    end
    it "should have the g(hbtm)-g(htbm) privilege o-on-o" do
      @person.has_privilege?(User::BAN,:on=> @user).should == false
      acl=@person.grant_permission!(User::BAN,:on => @user)
      @person.has_privilege?(User::BAN,:on => @user).should == true
    end
  end
  describe "with habtm - has_many" do
    before do
      User.delete_all
      UserGroup.delete_all
      
      @user=User.create!(:login => 'user1')
      @root_group = UserGroup.create!(:description => 'root')
      @users = UserGroup.create!(:description => 'users')
      @users.move_to_child_of(@root_group)
      @users.users << @user 
      
      Person.delete_all
      Family.delete_all
      @root_family = Family.create!(:name => 'The Frankensteins')
      @monsters = Family.create!(:name => 'Monsters')
      @monsters.move_to_child_of(@root_family)
      @person=@monsters.people.create(:name => 'person1')

    end
    it "should have the privilege g-on-g" do
      @user.has_privilege?(User::BAN,:on=> @person).should == false
      acl=@users.grant_permission!(User::BAN,:on => @monsters)
      @user.active_acl_clear_cache!
      @user.has_privilege?(User::BAN,:on => @person).should == true
    end
    it "should have the privilege o-on-g" do
      @user.has_privilege?(User::BAN,:on=> @person).should == false
      acl=@user.grant_permission!(User::BAN,:on => @monsters)
      @user.has_privilege?(User::BAN,:on => @person).should == true
    end
    it "should have the privilege g-on-o" do
      @user.has_privilege?(User::BAN,:on=> @person).should == false
      acl=@users.grant_permission!(User::BAN,:on => @person)
      @user.active_acl_clear_cache!
      @user.has_privilege?(User::BAN,:on => @person).should == true
    end
    it "should have the privilege o-on-o" do
      @user.has_privilege?(User::BAN,:on=> @person).should == false
      acl=@user.grant_permission!(User::BAN,:on => @person)
      @user.has_privilege?(User::BAN,:on => @person).should == true
    end
  end
  describe "with has_many - has_many" do
    before do
      
      Person.delete_all
      Family.delete_all
      @root = Family.create!(:name => 'root')
      @rs = Family.create!(:name => 'requesters')
      @rs.move_to_child_of(@root)
      @r=@rs.people.create(:name => 'requester')

      @ts = Family.create!(:name => 'targets')
      @ts.move_to_child_of(@root)
      @t=@ts.people.create(:name => 'target')

    end
    it "should have the privilege g-on-g" do
      @r.has_privilege?(User::BAN,:on=> @t).should == false
      acl=@rs.grant_permission!(User::BAN,:on => @ts)
      @r.active_acl_clear_cache!
      @r.has_privilege?(User::BAN,:on => @t).should == true
    end
    it "should have the privilege o-on-g" do
      @r.has_privilege?(User::BAN,:on=> @t).should == false
      acl=@r.grant_permission!(User::BAN,:on => @ts)
      @r.has_privilege?(User::BAN,:on => @t).should == true
    end
    it "should have the privilege g-on-o" do
      @r.has_privilege?(User::BAN,:on=> @t).should == false
      acl=@rs.grant_permission!(User::BAN,:on => @t)
      @r.active_acl_clear_cache!
      @r.has_privilege?(User::BAN,:on => @t).should == true
    end
    it "should have the privilege o-on-o" do
      @r.has_privilege?(User::BAN,:on=> @t).should == false
      acl=@r.grant_permission!(User::BAN,:on => @t)
      @r.has_privilege?(User::BAN,:on => @t).should == true
    end
  end

end
