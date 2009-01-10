require 'test_helper'
require 'authlogic/testing/test_unit_helpers'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = Factory :user
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => { :login => "ben", :password => "benrocks", :password_confirmation => "benrocks" }
    end
    
    assert_redirected_to account_path
  end
  
  test "should show user" do
    set_session_for(@user)
    get :show
    assert_response :success
  end
 
  test "should get edit" do
    set_session_for(@user)
    get :edit, :id => @user.id
    assert_response :success
  end
 
  test "should update user" do
    set_session_for(@user)
    put :update, :id => @user.id, :user => { }
    assert_redirected_to account_path
  end
end