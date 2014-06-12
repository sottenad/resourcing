class AccountsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]



  # GET /accounts/new
  def new
    @account = Account.new
    @user = @account.users.build
  end	

  # POST /accounts
  # POST /accounts.json
  def create
    

    @account = Account.create!(account_params)
	   ActsAsTenant.with_tenant(@account) do
	     @user = User.new(user_params)
	     @user.role = "admin"
	     if @user.save
	     	puts @user
	        sign_in_and_redirect(@user)
	     else
	       render :new
	     end
	end
    
  end


  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:title, :subdomain)
    end
    def user_params
    	params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
