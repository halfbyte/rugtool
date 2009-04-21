require 'open-uri'


class FeedCache < ActiveRecord::Base

  validates_presence_of :title, :url, :source, :source_url

  named_scope :for_source, lambda { |source| { :conditions => { :source => source }, :limit => 20, :order => 'posted_at DESC' } }

  def self.read_feed(url, source)
    feed = FeedTools::Feed.open(url)    
    feed.items.each do |item|
      fc = FeedCache.find_by_url(item.link) || FeedCache.new(:source_url => url)
      if fc.new_record? || (fc.posted_at < (item.updated || item.published))
        fc.attributes = { :url => item.link, :source_url => url, :source => source, :title => item.title, :description => item.description }
        fc.posted_at = (item.updated || item.published)
      end
    end
  end
end
