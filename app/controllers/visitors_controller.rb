class VisitorsController < ApplicationController
	before_filter :authenticate_user!
	
	def index
		@account = User.find(3).account
	end
end
