class Allocation < ActiveRecord::Base
	belongs_to :user
	belongs_to :project

	def duration_in_days
		duration = (self.end_date.to_date - self.start_date.to_date).to_i
		return duration.to_s + " Days"
		
	end
end