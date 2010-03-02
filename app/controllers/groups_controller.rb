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


  def update
    @group = object
    if verify_recaptcha(:model => @group) && @group.update_attributes(params[:group])
      flash[:notice] = "Thanks for editing your group"
      redirect_to @group
    else
      render :action => 'edit'
    end

  end

  def create
    @group = Group.new(params[:group])
    if verify_recaptcha(:model => @group) && @group.save
      flash[:notice] = "Thanks for adding your group"
      redirect_to @group
    else
      render :action => 'new'
    end
  end

private

  def object
    @object ||= Group.find_by_url_slug(params[:id])
  end

end
