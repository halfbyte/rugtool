class EventsController < ApplicationController
  def index
    @events = Event.all(:order => 'starts_at ASC', :conditions => ['starts_at >= ?', Time.now])
  end

end
