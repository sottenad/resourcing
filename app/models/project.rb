class Project < ActiveRecord::Base
	has_one :project_status
	has_one :user
	
end
