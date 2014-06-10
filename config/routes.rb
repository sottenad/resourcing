Rails.application.routes.draw do

  


  get 'marketing/index'
  get 'marketing/features'
  get 'marketing/pricing'

    resources :accounts

	resources 'subscription_types'
	resources 'allocations'
	resources 'subscriptions'
	resources 'projects'

	mount StripeEvent::Engine => '/stripe-hooks'
	

	as :user do
	  patch '/user/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
	end

	devise_for :users, :controllers => { :confirmations => "confirmations" }
	
	resources :users
		
	
	
	authenticated :user do
	  root :to => "visitors#index", :as => "user_root"
	end
	root :to => "marketing#index"

end
