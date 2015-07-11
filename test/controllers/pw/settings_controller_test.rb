require 'test_helper'

class Pw::SettingsControllerTest < ActionController::TestCase
  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get account" do
    get :account
    assert_response :success
  end

  test "should get users" do
    get :users
    assert_response :success
  end

end
