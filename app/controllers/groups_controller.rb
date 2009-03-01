class GroupsController < ApplicationController
  
  permit 'moderator for Group', :only => [:destroy]
  
  resource_controller

  def show
    object
    @group = @object
    if (@group.geocoded?)
      @map = GMap.new("map_div")
      @map.control_init(:large_map => true,:map_type => true)
      @map.center_zoom_init([@group.lat, @group.lng],7)
      @map.overlay_init(GMarker.new([@group.lat, @group.lng]))
    end
  end

  def index
    @group = Group.new
    @groups = Group.all
  end

private

  def object
    @object ||= Group.find_by_url_slug(params[:id])
  end
  
end
