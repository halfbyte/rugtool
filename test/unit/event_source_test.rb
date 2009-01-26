require 'test_helper'

class EventSourceTest < ActiveSupport::TestCase
  should_require_attributes :title, :url, :source_type
  
  context "named scopes" do
    should "find only accepted event sources on accepted"
    should "find only not accepted event sources on not_accepted"
    
  end
  
  context "convert_url" do
    should "convert webcal-urls to http" do
      event_source = EventSource.new({:title => 'foo', :url => 'webcal://example.com/webcal.ics', :source_type => 'ics'})
      event_source.valid?
      assert_match(/^http:\/\//, event_source.url)
    end
    should "convert feed-urls to http" do
      event_source = EventSource.new({:title => 'foo', :url => 'feed://example.com/feed', :source_type => 'feed'})
      event_source.valid?
      assert_match(/^http:\/\//, event_source.url)
    end
  end
  
end
