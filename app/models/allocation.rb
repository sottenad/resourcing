class Allocation < ActiveRecord::Base
	belongs_to :user
	belongs_to :project
	
	acts_as_tenant(:account)

	def duration_in_days
		duration = (self.end_date.to_date - self.start_date.to_date).to_i
		return duration
		
	end

end
