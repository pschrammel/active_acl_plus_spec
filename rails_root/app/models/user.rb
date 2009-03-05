# == Schema Information
# Schema version: 2
#
# Table name: users
#
#  id    :integer         not null, primary key
#  login :string(255)     not null
#  type  :string(255)
#

class User < ActiveRecord::Base
  has_and_belongs_to_many :user_groups
  acts_as_access_object :grouped_by => :user_groups
  privilege_const_set('BAN')
  privilege_const_set('LOGIN')
end
