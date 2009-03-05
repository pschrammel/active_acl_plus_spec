require File.dirname(__FILE__) + '/../spec_helper'

describe "ActiveAcl::ControllerGroup" do
  it "should " do
    ActiveAcl::CONTROLLERS.delete('ActionTestController')
    ActiveAcl::CONTROLLERS.delete('unassigned_controller_actions')      
    Object.send(:remove_const, 'ActionTestController') if Object.const_defined?('ActionTestController')
    ActiveAcl::ControllerAction.delete_all
    ActiveAcl::ControllerGroup.delete_all
    
#ActiveAcl::ControllerGroup.send(:set_table_name, 'garbage')
#    Object.instance_eval do
#      load "#{Rails.root}/app/controllers/action_test_controller.rb"
#    end
    
    
    #ActionTestController
    
    
    
    
    
    
    
    
    
    ActiveAcl::ControllerGroup.send(:set_table_name, ActiveAcl::OPTIONS[:controller_groups_table])
  end
end