class User < ActiveRecord::Base

  # Added by Koudoku.
  has_one :subscription


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
  #:registerable,
   :confirmable, :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_one :user_status
  has_one :user_group
  has_many :allocations
  
  def set_default_role
    self.role ||= :user
  end
  

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  # new function to set the password without knowing the current password used in our confirmation controller. 
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end
  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # new function to provide access to protected method unless_confirmed
	def only_if_unconfirmed
	  pending_any_confirmation {yield}
	end  
	
  #To Create New Users by the Admin
  def self.create_new_user(email)
    user = User.new({ :email => email })
    return user.save
  end
	
end
