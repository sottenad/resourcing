class VisitorsController < ApplicationController
	#before_filter :signed_in?
	before_filter :authenticate_user!
	
	def index
		@account = current_user.account	
		@total_hours = Allocation.sum(:total_hours)
	end
end
