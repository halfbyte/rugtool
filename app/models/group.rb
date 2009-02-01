class Group < ActiveRecord::Base
  
  validates_format_of :url_slug, :with => /^[a-z0-9\-_]+$/, :message => 'darf nur ASCII-Kleinbuchstaben, Ziffern und - und _ enthalten'
  validates_uniqueness_of :url_slug
  validates_presence_of :title, :url_slug, :description
  

  def to_param
    self.url_slug
  end
  
end
