require 'test_helper'

class SubscriptionTypesControllerTest < ActionController::TestCase
  setup do
    @subscription_type = subscription_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscription_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subscription_type" do
    assert_difference('SubscriptionTypes.count') do
      post :create, subscription_type: { price: @subscription_type.price, subscription_name: @subscription_type.subscription_name }
    end

    assert_redirected_to subscription_type_path(assigns(:subscription_type))
  end

  test "should show subscription_type" do
    get :show, id: @subscription_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subscription_type
    assert_response :success
  end

  test "should update subscription_type" do
    patch :update, id: @subscription_type, subscription_type: { price: @subscription_type.price, subscription_name: @subscription_type.subscription_name }
    assert_redirected_to subscription_type_path(assigns(:subscription_type))
  end

  test "should destroy subscription_type" do
    assert_difference('SubscriptionTypes.count', -1) do
      delete :destroy, id: @subscription_type
    end

    assert_redirected_to subscription_types_index_path
  end
end
