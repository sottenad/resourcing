class User < ActiveRecord::Base

  validates :first_name, :last_name, :email, :presence => true
  validates :password, :confirmation => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  enum role: [:user, :vip, :admin]
  
  after_initialize :set_default_role, :if => :new_record?
  before_destroy :delete_allocations

  has_one :user_status
  belongs_to :user_group
  has_one :subscription
  has_many :allocations
  
  belongs_to :account
  acts_as_tenant(:account)

  def delete_allocations
  	Allocation.destroy_all(:user => self)
  end	
  
  def set_default_role
    self.role ||= :user
  end
  

#  def password_required?
#    super if confirmed?
#  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  # new function to set the password without knowing the current password used in our confirmation controller. 
#  def attempt_set_password(params)
#    p = {}
#    p[:password] = params[:password]
#    p[:password_confirmation] = params[:password_confirmation]
#    update_attributes(p)
#  end
  
  # new function to return whether a password has been set
#  def has_no_password?
#    self.encrypted_password.blank?
#  end

  # new function to provide access to protected method unless_confirmed
#	def only_if_unconfirmed
#	  pending_any_confirmation {yield}
#	end  
	
  #To Create New Users by the Admin
  def self.create_new_user(email)
    user = User.new({ :email => email })
    return user.save
  end
  
  #Get this users card(s)
  def get_cards
  	if (!stripe_customer_id.nil?)
	  customer = Stripe::Customer.retrieve(stripe_customer_id)
	  puts customer.cards
	  return customer.cards
	else
		return nil
	end
  end
	
end
