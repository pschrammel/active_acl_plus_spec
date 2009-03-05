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

# for testing STI
class StiForum < Forum
end
