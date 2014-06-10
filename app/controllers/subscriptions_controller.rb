class SubscriptionsController < ApplicationController

require 'stripe'

before_action :authenticate_user!
before_filter :prevent_duplicate_subscription, :only => [:new, :create]

  def index

  	@subscription_types = SubscriptionType.all.order(:price)
  	@subscription = current_user.subscription
  	@user = current_user
  end

  def new
  	@user = current_user
  	@cards = @user.get_cards
  	@subscription_type = SubscriptionType.find(params[:plan])
  	@subscription = Subscription.new
  end

  def show
  	@subscription = Subscription.find(params[:id])
  end
  
  def edit
  	@subscription = Subscription.find(params[:id])
  	@subscription_type = @subscription.subscription_type

  end
  
  def update
  	@subscription = Subscription.find(params[:id])
  	@subscription.update(subscription_params)
  	@subscription.save
  	
  	flash[:notice] = "Subscription Updated"
  	redirect_to subscriptions_path
  	
  end
  
  def create
	session[:return_to] ||= request.referer
	selected_subcription_type = SubscriptionType.find(params[:subscription][:subscription_type_id])
	
	Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
	
	# Create a Customer
	
		begin
			if(!current_user.stripe_customer_id)
				token = params[:stripeToken]
				customer = Stripe::Customer.create(
				  :card => token,
				  :plan => selected_subcription_type.stripe_plan_id,
				  :email => current_user.email
				)
				#Save some details to our db
				current_user.update({:stripe_customer_id => customer.id})
				current_user.save
			else
				customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
				customer.subscriptions.create(:plan => selected_subcription_type.stripe_plan_id)
			end
			
			rescue Stripe::CardError => e
			  # The card has been declined
			  body = e.json_body
			  err  = body[:error]
			  flash[:error] = "Theres been an error: " + err[:message]
			  redirect_to session.delete(:return_to) 
			  return
		end
		
	
	
  	@subscription = Subscription.new(subscription_params)
  	@subscription.user = current_user
  	@subscription.active = true
  	@subscription.save
  	#Check stripe initializer for webhook to record subscription_id
  	
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
