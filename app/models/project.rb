class Project < ActiveRecord::Base
	has_one :project_status
	has_one :user
	has_many :allocations
	
end
