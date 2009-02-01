require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  context "index action" do
    should "assign to group and groups" do
      get :index
      assert_not_nil assigns(:group)
      assert_not_nil assigns(:groups)
    end
  end
  
  context "access restriction" do
    should "test access restriction"
  end
  
end
