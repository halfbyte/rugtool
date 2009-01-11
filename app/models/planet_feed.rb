class PlanetFeed < ActiveRecord::Base
  
  named_scope :accepted, :conditions => "accepted_at IS NOT NULL"
  named_scope :not_accepted, :conditions => "accepted_at IS NULL"
  
  before_validation :load_feed
  
  validate :validate_feed
  validates_presence_of :feed_url
  validates_presence_of :source_url, :message => "ist nicht vorhanden in dem Feed, das geht aber nicht!"
  validates_presence_of :title, :message => "ist nicht vorhanden in dem Feed, das geht aber nicht!"
  validates_uniqueness_of :source_url, :message => "ist bereits vorhanden. d.h. dieser Feed wurde schon vorgeschlagen"
  
  acts_as_authorizable
  
  attr_protected :accepted_at
  
  def accepted
    !accepted_at.nil?
  end
  
  def accepted=(acc)
    if (acc == "1")
      self.accepted_at = Time.now
    else
      self.accepted_at = nil
    end
  end
  
private
  def load_feed
    return if self.feed_url.blank?
    @feed = FeedTools::Feed.open(self.feed_url)
    self.feed_url = @feed.url
    self.title ||= @feed.title #to allow the admin to edit the title
    self.source_url = @feed.link
  rescue FeedTools::FeedAccessError
    @feed = nil
  end
  
  def validate_feed
    if !@feed.nil? && @feed.feed_type.nil?
      errors.add(:feed_url, "ist offensichtlich keine gültige Feed-URL")
    end
  end  
  
end
