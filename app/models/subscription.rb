class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscription_type
  
  validates :user, presence: true, uniqueness: true

end
