class AllocationsController < ApplicationController
  def index
  	@allocations = Allocation.all
  	  
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
