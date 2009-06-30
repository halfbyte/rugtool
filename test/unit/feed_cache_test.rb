require 'test_helper'

class FeedCacheTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  should_validate_presence_of :title, :url, :source, :source_url
  
  context "named scope for_source" do
    
    setup do
      @excluded = Factory(:feed_cache)
      @included1 = Factory(:feed_cache, :source => 'doo', :posted_at => 3.days.ago)
      @included2 = Factory(:feed_cache, :source => 'doo', :posted_at => 2.days.ago)
    end
    
    should "give FeedCache entries with correct source" do
      feeds = FeedCache.for_source('doo')
      assert feeds.include?(@included1)
      assert feeds.include?(@included2)
      assert !feeds.include?(@excluded)
    end
    
    should "give FeedCache entries in correct order" do
      feeds = FeedCache.for_source('doo')
      assert feeds.index(@included1) > feeds.index(@included2)
    end
    
  end
  
  context "read_feeds" do
    
  end
  
end
