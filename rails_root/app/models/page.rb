#example of an ungrouped target
class Page < ActiveRecord::Base
  acts_as_access_object
  privilege_const_set('VIEW')
  privilege_const_set('DELETE')
  privilege_const_set('EDIT')
end
