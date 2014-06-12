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
	

	root :to => "visitors#index"

	
	#User Stuff

	as :user do
	  patch '/user/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
	end
	devise_for :users, :controllers => { :confirmations => "confirmations" }
	resources :users

end
