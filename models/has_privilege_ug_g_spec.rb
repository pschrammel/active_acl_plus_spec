require File.dirname(__FILE__) + '/../spec_helper'

describe "3d privileges (ungrouped - grouped)" do
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
  
  #tests for a 2d privilege on a grouped object
  
  describe "with habtm" do
    before do
      User.delete_all
      UserGroup.delete_all
      Company.delete_all
      @user=User.create!(:login => 'user1')
      @company=Company.create!(:name => 'gaagle')
      @root_group = UserGroup.create!(:description => 'root')
      @users = UserGroup.create!(:description => 'users')
      @users.move_to_child_of(@root_group)
      @users.users << @user 
      
    end
    it "should have the o-o privilege" do
      @company.has_privilege?(User::BAN,:on=> @user).should == false
      acl=@company.grant_permission!(User::BAN,:on => @user)
      @company.has_privilege?(User::BAN,:on=> @user).should == true
    end
    it "should have the o-g(hbtm) privilege" do
      @company.has_privilege?(User::BAN,:on=> @user).should == false
      acl=@company.grant_permission!(User::BAN,:on => @users)
      @company.has_privilege?(User::BAN,:on=> @user).should == true
    end
    
  end

  describe "with has_many" do
    before do
      Person.delete_all
      Family.delete_all
      Company.delete_all
      @root_family = Family.create!(:name => 'The Frankensteins')
      @monsters = Family.create!(:name => 'Monsters')
      @monsters.move_to_child_of(@root_family)
      @person=@monsters.people.create(:name => 'person1')
      
      @company=Company.create!(:name => 'gaagle')
      
    end
    it "should have the o-o privilege" do
      @company.has_privilege?(User::BAN,:on=> @person).should == false
      acl=@company.grant_permission!(User::BAN,:on => @person)
      @company.has_privilege?(User::BAN,:on=> @person).should == true
    end
    it "should have the o-g(hbtm) privilege" do
      @company.has_privilege?(User::BAN,:on=> @person).should == false
      acl=@company.grant_permission!(User::BAN,:on => @monsters)
      @company.has_privilege?(User::BAN,:on=> @person).should == true
    end
  end
  
end
