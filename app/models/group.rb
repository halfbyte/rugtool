class Group < ActiveRecord::Base
  
  acts_as_mappable :default_units => :kms, :default_formula => :flat
  
  BLACKLISTED_URL_SLUGS = ['event_sources', 'events', 'groups', 'planet_feeds', 'user_sessions', 'users']
  
  validates_format_of :url_slug, :with => /^[a-z0-9\-_]+$/, :message => 'darf nur ASCII-Kleinbuchstaben, Ziffern und - und _ enthalten'
  validates_uniqueness_of :url_slug
  validates_presence_of :title, :url_slug, :description
  
  before_validation :geocode_before_validation
  
  validate :validates_against_url_slug_blacklist

  def to_param
    self.url_slug
  end

private
  def validates_against_url_slug_blacklist
    if BLACKLISTED_URL_SLUGS.include?(self.url_slug)
      errors.add(:url_slug, 'is invalid, probably blacklisted. choose a different one')
    end
  end
  
  
  def geocode_before_validation
    return true if self.location.blank?
    res = geocode_for(self.location)
    if res
      self.lat, self.lng = res
    else
      errors.add(:location, "could not geocode this address")
    end
  end
  
  def geocode_for(address)
    res = MultiGeocoder.geocode(address)
    if res.success
      [res.lat,res.lng]
    else
      nil
    end
  end
    
end
