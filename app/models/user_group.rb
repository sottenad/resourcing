class UserGroup < ActiveRecord::Base
	belongs_to :user
	#belongs_to :account
	act_as_tenant(:account)
end
