class SubscriptionsController < ApplicationController

require 'stripe'

before_action :authenticate_user!
before_filter :prevent_duplicate_subscription, :only => [:new, :create]

  def index
  	@subscription_types = SubscriptionType.all
  	@subscriptions = Subscription.all
  	@user = current_user
  end

  def new
  	@subscription_type = SubscriptionType.find(params[:plan])
  	@subscription = Subscription.new
  end

  def show
  	@subscription = Subscription.find(params[:id])
  end
  
  def edit
  	@subscription = Subscription.find(params[:id])
  end
  
  def update
  	@subscription = Subscription.find(params[:id])
  	@subscription.update(subscription_params)
  	@subscription.save
  	
  	flash[:notice] = "Subscription Updated"
  	redirect_to subscriptions_path
  	
  end
  
  def create
	
	Stripe.api_key = ENV["STRIPE_SECRET_KEY"]

	# Get the credit card details submitted by the form
	token = params[:stripeToken]
	
	# Create a Customer
	customer = Stripe::Customer.create(
	  :card => token,
	  :plan => "basic",
	  :email => current_user.email
	)
	current_user.update({:stripeid => customer.id})
	current_user.save
	
  	@subscription = Subscription.new(subscription_params)
  	@subscription.user = current_user
  	@subscription.active = true
  	@subscription.save
  	
  	if @subscription.errors.any?
	  	#TODO: add error messaging and logging
  		flash[:error] = "Could Not add Subscription. Please try again later."
  		redirect_to subscriptions_path
  	else
  		flash[:notice] = "Added Subscription"
  		redirect_to subscriptions_path
  	end
  end
  
  def destroy
  	@subscription = Subscription.find(params[:id])
  	@subscription.destroy
  	redirect_to subscriptions_path
  end
  
	private
		
	def subscription_params
		params.require(:subscription).permit(:user_id, :subscription_type_id, :active)
	end
	
	protected 
	def prevent_duplicate_subscription
		if(current_user.subscription)
			flash[:notice] = "You can only have one subscription"
			redirect_to subscriptions_path
		end
	end

end
