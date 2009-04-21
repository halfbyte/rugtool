class HomeController < ApplicationController
  def index
    @title = "Willkommen"
    @events = Event.find(:all, :limit => 10, :conditions => ['starts_at > ?', Time.now], :order => 'starts_at ASC')
    @groups = Group.all(:limit => 10)
    
    @news = FeedCache.for_source('ug-tumble')
    
    @map = GMap.new("map_div")
    @map.control_init(:large_map => true,:map_type => true)
    @map.center_zoom_init([51.133333, 10.416667],5)
    markers = @groups.select{|g| g.geocoded? }.map do |g|
      @map.add_overlay GMarker.new([g.lat,g.lng], :title => "#{g.title}", :info_window => "<b><a href='#{group_path(g)}'>#{g.title}</a></b>")
    end
    @map.record_init(markers.join(";"))
  end

end
