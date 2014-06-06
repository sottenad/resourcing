class SubscriptionTypesController < ApplicationController
  before_action :set_subscription_type, only: [:show, :edit, :update, :destroy]

  # GET /subscription_types
  # GET /subscription_types.json
  def index
    @subscription_types = SubscriptionType.all
  end

  # GET /subscription_types/1
  # GET /subscription_types/1.json
  def show
  end

  # GET /subscription_types/new
  def new
    @subscription_type = SubscriptionType.new
  end

  # GET /subscription_types/1/edit
  def edit
  end

  # POST /subscription_types
  # POST /subscription_types.json
  def create
    @subscription_type = SubscriptionType.new(subscription_type_params)

    respond_to do |format|
      if @subscription_type.save
        format.html { redirect_to @subscription_type, notice: 'Subscription types was successfully created.' }
        format.json { render :show, status: :created, location: @subscription_type }
      else
        format.html { render :new }
        format.json { render json: @subscription_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscription_types/1
  # PATCH/PUT /subscription_types/1.json
  def update
    respond_to do |format|
      if @subscription_type.update(subscription_type_params)
        format.html { redirect_to @subscription_type, notice: 'Subscription types was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription_type }
      else
        format.html { render :edit }
        format.json { render json: @subscription_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscription_types/1
  # DELETE /subscription_types/1.json
  def destroy
    @subscription_type.destroy
    respond_to do |format|
      format.html { redirect_to subscription_type_index_url, notice: 'Subscription types was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription_type
      @subscription_type = SubscriptionType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_type_params
      params.require(:subscription_type).permit(:subscription_name, :price)
    end
end
