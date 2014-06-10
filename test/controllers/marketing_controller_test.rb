require 'test_helper'

class MarketingControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get features" do
    get :features
    assert_response :success
  end

  test "should get pricing" do
    get :pricing
    assert_response :success
  end

end
