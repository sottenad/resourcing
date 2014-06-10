class UsersController < ApplicationController
  before_filter :authenticate_user!
  #after_action :verify_authorized, except: [:show]

  def index
    @users = User.all
    @new_user = User.new
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
  
  def create
  	@users = User.all
    @new_user = User.new(secure_params)
    respond_to do |format|
      if @new_user.save
        format.html { redirect_to users_path }
      else
      	format.html { render :action => "index" }
      end
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  private

  def secure_params
    params.require(:user).permit(:role,:email,:first_name,:last_name)
  end

end
