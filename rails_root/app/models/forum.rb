# == Schema Information
# Schema version: 2
#
# Table name: forums
#
#  id          :integer         not null, primary key
#  name        :string(255)     not null
#  tag         :string(255)
#  type        :string(255)
#  category_id :integer         not null
#

#example of a grouped target (not habtm)
class Forum < ActiveRecord::Base
  belongs_to :category
  acts_as_access_object :grouped_by => :category
  
  privilege_const_set('ADMIN' => 'administrate the forum',
                       'EDIT' => 'edit own postings',
                       'MODERATE' => 'moderate the forum',
                       'VIEW' => 'view this forum in category view',
                       'READ' => 'read postings in this forum',
                       'REPLY' => 'add postings to a thread',
                       'CREATE' => 'create a thread')
end
