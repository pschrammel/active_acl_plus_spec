#example of an ungrouped requester
class Company < ActiveRecord::Base
  acts_as_access_object
  privilege_const_set('POST_AD')
end