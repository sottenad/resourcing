class ProjectsController < ApplicationController
  def index
  	@projects = Project.all
  	  
  end


  def show
  	@project = Project.find(params[:id])
  end

  def new
  	@project = Project.new
  end
  
  def destroy
  	@project = Project.find(params[:id])
  	
  	flash[:notice] = @project.title+ " deleted."
  	
  	@project.destroy  
  	redirect_to projects_path
  end

  def create
  	@project = Project.new(project_params)
  	@project.save
  	redirect_to projects_path
  end
  
	private
		
	def project_params
		params.require(:project).permit(:title, :budget_currency, :budget_hours, :number)
	end
	
end
