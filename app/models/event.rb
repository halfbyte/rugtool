class Event < ActiveRecord::Base

  require 'open-uri'

  validates_presence_of :title, :uid, :starts_at
  
  ##############################################
  # Import actions
  ##############################################
  
  # importing from generic feed. tries to parse the content with mofo. if given a block,
  # mofo parsing is skipped and you can do your own parsing.
  # the parser should set starts_at, since this is the only field that we can not populate
  # from standard feed elements
  # TODO: Try to autodetect xcal elements in feed, since this is what upcoming.yahoo.com is using
  # 
  
  def self.import_from_feed(url)
    feed = FeedTools::Feed.open(url)
    feed.items.each do |item|
      event = Event.find_by_uid(item.id) || Event.new
      if event.new_record? || (event.remote_updated_at < (item.updated || item.published))
        event.attributes = {:uid => item.id, :url => item.link, :description => item.description, :title => item.title}
        event.remote_updated_at = (item.updated || item.published)
        if block_given?
          yield(event, item)
        else
          cal = hCalendar.find(:first, :text => item.content)
          event.starts_at = cal.dtstart if cal != []
        end
        if event.save
          logger.info "imported/updated #{event.title}"
        else
          logger.info "discarding #{event.url} because save failed"
        end          
      else
        logger.info "skipping non-updated event"
      end
    end
  end
  
  def self.import_from_ics(url)
    cals = Icalendar.parse(open(url))
    cal = cals.first
    cal.events.each do |item|
      event = Event.find_by_uid(item.uid) || Event.new
      if event.new_record? || (event.remote_updated_at < item.dtstamp)
        event.attributes = {
          :uid => item.uid,
          :url => item.url,
          :description => item.description || "", #might be empty. too bad.
          :title => item.summary,
          :starts_at => item.dtstart,
          :remote_updated_at => item.dtstamp
        }
        if event.save
          logger.info "imported/updated #{event.title}"
        else
          logger.info "discarding #{event.url} because save failed"
        end                  
      end
    end
  end
  
end
