require 'test_helper'

class EventTest < ActiveSupport::TestCase
  
  should_require_attributes :title, :description, :url, :starts_at
  
  context "Import processes" do
    context "venteria" do
      should "create new events" do
        assert_difference "Event.count", 6 do
          Event.import_from_venteria_feed(File.join(RAILS_ROOT, "test", "fixtures", "venteria_events.atom"))
        end
      end
    end
  end
end
