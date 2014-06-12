class ApplicationController < ActionController::Base
  #include the application helper - some conditional helpers here
  include ApplicationHelper
  
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?



  set_current_tenant_through_filter
  before_filter :your_method_that_finds_the_current_tenant
  def your_method_that_finds_the_current_tenant
    current_account = Account.find(1)
    set_current_tenant(current_account)
  end
  
  
  
  protected

	def configure_permitted_parameters
	  # Only add some parameters
	  devise_parameter_sanitizer.for(:sign_up).concat [:first_name, :last_name, :phone, :user_group] 
	  devise_parameter_sanitizer.for(:accept_invitation).concat [:first_name, :last_name, :phone, :user_group]
	  # Override accepted parameters
	  devise_parameter_sanitizer.for(:accept_invitation) do |u|
	    u.permit(:first_name, :last_name, :phone, :password, :password_confirmation, :invitation_token, :user_group)
	  end
	end


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end
  
	protected
	def ensure_subscription
		if(!current_user.subscription || !current_user.subscription.active)
			flash[:notice] = "Access Denied"
			redirect_to root_path
		end
	end
end
