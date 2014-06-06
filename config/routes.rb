Rails.application.routes.draw do

	resources 'subscription_types'
	resources 'allocations'
	resources 'subscriptions'
	resources 'projects'

	
	root :to => "visitors#index"

	as :user do
	  patch '/user/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
	end
	devise_for :users, :controllers => { :confirmations => "confirmations" }
	resources :users	
	

end
