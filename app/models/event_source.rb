class EventSource < ActiveRecord::Base
  named_scope :accepted, :conditions => "accepted_at IS NOT NULL"
  named_scope :not_accepted, :conditions => "accepted_at IS NULL"
  before_validation :convert_url
  
  validates_presence_of :url, :source_type, :title
  validates_uniqueness_of :url
  
  SOURCE_TYPES = [
    ['Autodetect', nil],
    ['Feed (Autodetect)','feed'],
    ['ICS / ICal', 'ical']
  ]
  
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
  
  
  def convert_url
    self.url.gsub!(/^(webcal|feed):\/\//, 'http://') if self.url
  end
  
end
