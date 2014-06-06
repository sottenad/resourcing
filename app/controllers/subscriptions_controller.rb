class SubscriptionsController < ApplicationController
before_action :authenticate_user!
  def index
  	@subscriptions = Subscription.all
  	@user = current_user
  end

  def new
  	@subscription = Subscription.new
  end

  def show
  	@subscription = Subscription.find(params[:id])
  end
  
  def create
  	@subscription = Subscription.new(subscription_params)
  	@subscription.save
  	redirect_to subcriptions_path
  end
  
  
  private
  	def subscription_params
  		require(:subscription).permit(:subscription_type)
  	end

  
end
