Rails.application.routes.draw do

  


  
  resources :user_groups

  get 'marketing/index'
  get 'marketing/features'
  get 'marketing/pricing'

    resources :accounts

	resources 'subscription_types'
	resources 'allocations'
	resources 'subscriptions'
	resources 'projects'

	mount StripeEvent::Engine => '/stripe-hooks'
	

	authenticated :user do
	  root :to => "visitors#index", :as => 'signed_in_root'
	end
	root :to => "marketing#index"
	

	as :user do
	  patch '/user/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
	end
	devise_for :users, :controllers => { :confirmations => "confirmations" }
	resources :users

	namespace :api do
		
	    get 'allocations'
	    get 'users'
	    
	  
	end

end
