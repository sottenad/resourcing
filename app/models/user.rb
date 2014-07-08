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

  def display_name
  	self.first_name + ' ' + self.last_name
  end
 
	
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
