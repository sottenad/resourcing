class UserGroup < ActiveRecord::Base
	has_many :users
	acts_as_tenant(:account)
end
