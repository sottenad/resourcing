class ApiController < ApplicationController

	def allocations
		if params["start"] && params["end"]
			@allocations = User.all.includes(:allocations).where('(allocations.start_date >= ? and allocations.start_date <= ?) or (allocations.end_date >= ? and allocations.end_date <= ?)', 
											params["start"].to_date, params["end"].to_date, params["start"].to_date, params["end"].to_date)
											.order("allocations.start_date ASC")

		else
			@allocations = Allocation.all
		end
	end
	
	def users
		@users = User.all
	end

end

