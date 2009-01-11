require 'test_helper'

class PlanetFeedTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def setup
    stub_feedtools
    #@feed = Factory(:planet_feed)
  end

  should_require_attributes(:feed_url)
  
  context "validations" do
    should "require attribute source_url" do
      FeedTools::Feed.any_instance.stubs(:link).returns(nil)
      @feed = Factory.build(:planet_feed)
      assert !@feed.valid?, "feed should not be valid"
    end
    
    should "require attribute title" do
      FeedTools::Feed.any_instance.stubs(:title).returns(nil)
      @feed = Factory.build(:planet_feed)
      assert !@feed.valid?, "feed should not be valid"      
    end

    should "keep source_url unique" do
      @feed = Factory(:planet_feed)
      #FeedTools::Feed.any_instance.stubs(:feed_url).returns(nil)
      @feed = Factory.build(:planet_feed)
      assert !@feed.valid?, "feed should not be valid"
    end
    
  end
  
end
