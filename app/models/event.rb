class Event < ActiveRecord::Base

  validates_presence_of :title, :description, :url, :starts_at

### Import actions
  def self.import_from_venteria_feed(url)
    feed = FeedTools::Feed.open(url)
    feed.items.each do |item|
      if !Event.find_by_url(item.link)
        event = Event.new(:url => item.link, :description => item.description, :title => item.title)
        doc = Hpricot(item.content)
        dtstart =  (doc / ".dtstart").first[:title]
        event.starts_at = Time.parse(dtstart)
        if (event.save)
          logger.info "imported #{event.title}"
        else
          logger.info "discarding #{event.url} because save failed"
        end
      else
        logger.info "discarding dupe: #{item.link}"
      end
    end
  end

end
