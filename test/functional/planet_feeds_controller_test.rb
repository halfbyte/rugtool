require 'test_helper'
require 'authlogic/testing/test_unit_helpers'

class PlanetFeedsControllerTest < ActionController::TestCase
  
  def setup
    stub_feedtools
  end
  
  context "index" do
    context "unauthorized" do
      setup do
        @feed = Factory(:planet_feed)
        get :index
      end
      
      should "return successful on get" do
        assert_response :success
      end
      should "assign planet_feed collections for templates" do
        assert_not_nil assigns(:planet_feeds)
        assert_not_nil assigns(:new_planet_feeds)
      end
      should "not contail admin links" do
        assert_select "a[href='#{edit_planet_feed_path(@feed)}']", false
        assert_select "a[href='#{planet_feed_path(@feed)}']", :text => 'delete', :count => 0
      end
    end
    
    context "authorized" do
      setup do
        @feed = Factory(:planet_feed)
        @user = Factory(:user)
        @user.has_role "moderator", PlanetFeed
        set_session_for(@user)
        get :index
      end
      
      should "contain admin links" do
        assert_select "a[href='#{edit_planet_feed_path(@feed)}']"
        assert_select "a[href='#{planet_feed_path(@feed)}']", :text => 'delete'
      end
    end
    
    context "planet list format" do
      setup do
        @feed = Factory(:planet_feed, :accepted_at => Time.now)
        get :index, :format => 'planet'
      end
      should "render with text/plain" do
        assert_equal "text/plain", @response.content_type
      end
      should "contain link to given feed" do
        assert_match /#{@feed.reload.feed_url}/, @response.body
      end
      
      should "contain square brackets" do
        assert_match /^\[.*\]$/, @response.body
      end
    end
    
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:planet_feeds)
    assert_not_nil assigns(:new_planet_feeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create planet_feed" do
    assert_difference('PlanetFeed.count') do
      post :create, :planet_feed => { :feed_url => "http://www.spiegel.de" }
    end

    assert_redirected_to planet_feeds_path
  end

  # test "should show planet_feed" do
  #   get :show, :id => planet_feeds(:one).id
  #   assert_response :success
  # end

  context "edit" do
    setup do
      @feed = Factory(:planet_feed)
      @user = Factory(:user)
    end
    should "not allow editing for not logged in user" do
      get :edit, :id => @feed.id
      assert_redirected_to new_user_session_url
    end    
    should "not allow editing for user without the correct role" do
      @user.has_no_role "moderator", PlanetFeed
      set_session_for(@user)
      get :edit, :id => @feed.id
      assert_redirected_to root_url
    end
    should "allow editing for user with moderator role for PlanetFeed" do
      @user.has_role "moderator", PlanetFeed
      set_session_for(@user)
      get :edit, :id => @feed.id
      assert_response :success
    end    
  end

  context "update" do
    setup do
      @feed = Factory(:planet_feed)
      @user = Factory(:user)
    end
    should "not allow updating for not logged in user" do
      put :update, :id => @feed.id, :planet_feed => {:accepted => "1"}
      assert_redirected_to new_user_session_url
    end    
    should "not allow updating for user without the correct role" do
      @user.has_no_role "moderator", PlanetFeed
      set_session_for(@user)
      put :update, :id => @feed.id, :planet_feed => {:accepted => "1"}
      assert_redirected_to root_url
    end
    should "allow editing for user with moderator role for PlanetFeed" do
      @user.has_role "moderator", PlanetFeed
      set_session_for(@user)
      put :update, :id => @feed.id, :planet_feed => {:accepted => "1"}
      assert_redirected_to planet_feeds_url
    end
    should "render edit template when validation fails" do
      @user.has_role "moderator", PlanetFeed
      set_session_for(@user)
      put :update, :id => @feed.id, :planet_feed => { :title => "" }
      assert_template 'planet_feeds/edit'
    end
  end
  
  context "destroy" do
    setup do
      @feed = Factory(:planet_feed)
      @user = Factory(:user)
    end
    should "not allow destroying for not logged in user" do
      delete :destroy, :id => @feed.id
      assert_redirected_to new_user_session_url
    end    
    should "not allow destroying for user without the correct role" do
      @user.has_no_role "moderator", PlanetFeed
      set_session_for(@user)
      delete :destroy, :id => @feed.id
      assert_redirected_to root_url
    end
    should "allow destroying for user with moderator role for PlanetFeed" do
      @user.has_role "moderator", PlanetFeed
      set_session_for(@user)
      delete :destroy, :id => @feed.id
      assert_redirected_to planet_feeds_url
    end
  end
end
