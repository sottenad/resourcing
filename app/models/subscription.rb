class Subscription < ActiveRecord::Base
  belongs_to :user
  has_one :subscription_type

end
