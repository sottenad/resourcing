Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
  :secret_key      => ENV['STRIPE_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

StripeEvent.configure do |events|
  events.subscribe 'charge.' do |event|
    # Define subscriber behavior based on the event object
    #puts event.class       #=> Stripe::Event
    #puts event.type        #=> "charge.failed"
    #puts event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>
  end
  
  #Record Subscription ID to User based on stripe customer id
  events.subscribe 'customer.subscription.created' do |event|
  	customer = User.find_by stripe_customer_id: event.data.object[:customer]
  	if(customer && customer.subscription)
  		customer.subscription.update({
  			:stripe_subscription_id => event.data.object[:id],
  			:trial_start => event.data.object[:trial_start],
  			:trial_end => event.data.object[:trial_end]
  		})
  		customer.save
  	end
  end
  
  events.subscribe 'customer.subscription.trial_will_end﻿' do |event|
  	#TODO: alert customers via email
  end
  
  #mark users subscription as :active => false if they dont pay their invoice.
  events.subscribe 'invoice.payment_failed' do |event|
  	customer = User.find_by stripe_customer_id: event.data.object[:customer]
  	if(customer && customer.subscription)
  		customer.subscription.update({:active => false})
  	end
  	#TODO: email user alerting them that their invoice failed and they need to fix it.
  end
  
  #Mark users subscription as :active => true if they fix their payment somehow w.o using our interface. Very Unlikely.
  #This also serves as backup for our active=true set when we create the subscription.
  events.subscribe 'invoice.payment_succeeded' do |event|
  	customer = User.find_by stripe_customer_id: event.data.object[:customer]
  	if(customer && customer.subscription)
  		customer.subscription.update({:active => false})
  	end
  end


  events.all do |event|
  	#TODO: Log all events
    # Handle all event types - logging, etc.
  end
end