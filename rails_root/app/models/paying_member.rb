# == Schema Information
# Schema version: 2
#
# Table name: users
#
#  id    :integer         not null, primary key
#  login :string(255)     not null
#  type  :string(255)
#

# for testing STI
class PayingMember < User
end
