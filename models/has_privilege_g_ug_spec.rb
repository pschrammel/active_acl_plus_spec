require File.dirname(__FILE__) + '/../spec_helper'

describe "3d privileges (grouped - ungrouped)" do
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
      Page.delete_all
      @user=User.create!(:login => 'user1')
      @page=Page.create!(:title => 'Startpage')
      @root_group = UserGroup.create!(:description => 'root')
      @users = UserGroup.create!(:description => 'users')
      @users.move_to_child_of(@root_group)
      @users.users << @user      
    end
    
    it "should have the o-o privilege" do
      @user.has_privilege?(Page::VIEW,:on=> @page).should == false
      acl=@user.grant_privilege!(Page::VIEW,:on => @page)
      @user.has_privilege?(Page::VIEW,:on => @page).should == true
    end
    
    it "should have the g-o privilege derived from group" do
      @user.has_privilege?(Page::VIEW,:on=> @page).should == false
      acl=@users.grant_privilege!(Page::VIEW,:on => @page)
      @user.active_acl_clear_cache!
      @user.has_privilege?(Page::VIEW,:on => @page).should == true
    end
    
    it "should have the g-o privilege derived from object" do
      @user.has_privilege?(Page::VIEW,:on=> @page).should == false
      acl=@user.grant_privilege!(Page::VIEW,:on => @page)
      @user.has_privilege?(Page::VIEW,:on => @page).should == true
    end
    
  end
  describe "with has_many" do
    before do
      Person.delete_all
      Family.delete_all
      Page.delete_all
      @root_family = Family.create!(:name => 'The Frankensteins')
      @monsters = Family.create!(:name => 'Monsters')
      @monsters.move_to_child_of(@root_family)
      @person=@monsters.people.create(:name => 'person1')
      @page=Page.create!(:title => 'Startpage')
    end
    
    it "should have the o-o privilege" do
      @person.has_privilege?(Page::VIEW,:on=> @page).should == false
      acl=@person.grant_privilege!(Page::VIEW,:on => @page)
      @person.has_privilege?(Page::VIEW,:on => @page).should == true
    end
    
    it "should have the g-o privilege derived from group" do
      @person.has_privilege?(Page::VIEW,:on=> @page).should == false
      acl=@monsters.grant_privilege!(Page::VIEW,:on => @page)
      @person.active_acl_clear_cache!
      @person.has_privilege?(Page::VIEW,:on => @page).should == true
    end
    
    it "should have the g-o privilege derived from object" do
      @person.has_privilege?(Page::VIEW,:on=> @page).should == false
      acl=@person.grant_privilege!(Page::VIEW,:on => @page)
      @person.has_privilege?(Page::VIEW,:on => @page).should == true
    end
    
  end
  
end
