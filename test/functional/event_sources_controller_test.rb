require 'test_helper'

class EventSourcesControllerTest < ActionController::TestCase
  context "creation" do
    should "create event source" do
      assert_difference "EventSource.count" do
        post :create, :event_source => {:url => 'http://www.example.com/ics', :source_type => 'ics', :title => 'Foobar'}
      end
    end
  end
end
