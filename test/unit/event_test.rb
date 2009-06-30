require 'test_helper'

class EventTest < ActiveSupport::TestCase
  
  should_validate_presence_of :title, :uid, :starts_at
  
  context "Importing Feeds with feedtools" do
    context "generic" do
      should "create event from rss feed with microformats" do
        assert_difference "Event.count",2 do
          Event.import_from_feed(File.join(RAILS_ROOT, "test", "fixtures", "wordpress_microformats.xml"))
        end
      end
      
      should "not create duplicates" do
        Event.import_from_feed(File.join(RAILS_ROOT, "test", "fixtures", "wordpress_microformats.xml"))
        assert_no_difference "Event.count" do
          Event.import_from_feed(File.join(RAILS_ROOT, "test", "fixtures", "wordpress_microformats.xml"))
        end
      end
      
      should "update events if changed" do
        Event.import_from_feed(File.join(RAILS_ROOT, "test", "fixtures", "wordpress_microformats.xml"))
        event = Event.find_by_uid("http://localhost3000.de/?p=74")
        assert_equal("Another event test", event.title)
        Event.import_from_feed(File.join(RAILS_ROOT, "test", "fixtures", "wordpress_microformats_update.xml"))
        assert_equal("Another event test, updated",event.reload.title)
      end
      
    end
    
    context "venteria" do
      should "create new events" do
        assert_difference "Event.count", 6 do
          Event.import_from_feed(File.join(RAILS_ROOT, "test", "fixtures", "venteria_events.atom")) do |event, item|
            doc = Hpricot(item.content)
            dtstart =  (doc / ".dtstart").first[:title]
            event.starts_at = Time.parse(dtstart)
          end
        end
      end
    end
    
    context "importing ics files" do
      should "create new events" do
        assert_difference "Event.count", 6 do
          Event.import_from_ics(File.join(RAILS_ROOT, "test", "fixtures", "venteria_ical.ics"))
        end
      end
      
    end
    
  end
end
