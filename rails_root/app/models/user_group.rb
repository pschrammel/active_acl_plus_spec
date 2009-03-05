# == Schema Information
# Schema version: 2
#
# Table name: user_groups
#
#  id          :integer         not null, primary key
#  description :string(255)     not null
#  lft         :integer         not null
#  rgt         :integer         not null
#  parent_id   :integer
#

class UserGroup < ActiveRecord::Base
  has_and_belongs_to_many :users
  acts_as_nested_set
  acts_as_access_group :type => ActiveAcl::Acts::AccessGroup::NestedSet
  
  privilege_const_set('CREATE')
end
