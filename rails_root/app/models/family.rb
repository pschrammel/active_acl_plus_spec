# == Schema Information
# Schema version: 2
#
# Table name: categories
#
#  id          :integer         not null, primary key
#  description :string(255)     not null
#  lft         :integer         not null
#  rgt         :integer         not null
#  parent_id   :integer
#


class Family < ActiveRecord::Base
  has_many :people
  acts_as_nested_set
  acts_as_access_group
end
