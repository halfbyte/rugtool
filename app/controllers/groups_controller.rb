class GroupsController < ApplicationController
  
  permit 'moderator for Group', :only => [:destroy]
  
  resource_controller

  def index
    @group = Group.new
    @groups = Group.all
  end

private

  def object
    @object ||= Group.find_by_url_slug(params[:id])
  end
  
end
