class HomeController < ApplicationController
  def index
    @title = "Willkommen"
    @events = Event.find(:all, :limit => 10, :conditions => ['starts_at > ?', Time.now], :order => 'starts_at ASC')
    @groups = Group.all(:limit => 10)
  end

end
