require 'test_helper'

class ProjectControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get view" do
    get :view
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

end
