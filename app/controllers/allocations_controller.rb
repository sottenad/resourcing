class AllocationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_subscription
  
  def index	
  	if(params[:email].nil?)
  		@allocations = Allocation.all.includes(:user).order("users.email desc")
  		@email_selected = User.first.email
  	else
  		@allocations = Allocation.joins(:user).where("users.email = ?", params[:email][:value])  	
  		@email_selected = params[:email][:value]
  	end
  	
  	@all_users = User.all.uniq
  	@all_projects = Project.all
  	
  	respond_to do |format|
  		format.html
  		format.json {render json:@allocations}
  	end
  end


  def show
  	@allocation = Allocation.find(params[:id])
  end

  def new
  	@allocation = Allocation.new
  end
  
  def destroy
  	@allocation = Allocation.find(params[:id])
  	
  	flash[:notice] = "Allocation deleted."
  	
  	@allocation.destroy  
  	redirect_to allocations_path
  end
  
  def update
  	@allocation = Allocation.find(params[:id])
  	@allocation.update(allocation_params)
  	flash[:notice] = "Allocation Changed"
  	redirect_to allocations_path
  end

  def create
  	@allocation = Allocation.new(allocation_params)
  	@allocation.save
  	redirect_to allocations_path
  end
  
	private
		
	def allocation_params
		params.require(:allocation).permit(:start_date, :end_date, :hours_per_day, :user_id, :project_id)
	end
	

	
	
end
