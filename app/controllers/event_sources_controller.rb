class EventSourcesController < ApplicationController
  
  before_filter :load_event_source, :only => [:edit, :update, :destroy]
  permit 'moderator for EventSource', :only => [:edit, :update, :destroy]
  
  
  
  def index
    @accepted_event_sources = EventSource.accepted
    @not_accepted_event_sources = EventSource.not_accepted
    @event_source = EventSource.new

  end
  
  def new
    @event_source = EventSource.new
  end
  
  def create
    @event_source = EventSource.new(params[:event_source])
    if @event_source.save
      flash[:notice] = "Event-Quelle wurde erstellt"
      redirect_to event_sources_path
    else
      render :action => 'new'
    end
  end

  def edit
    
  end
  
  def update
    if @event_source.update_attributes(params[:event_source])
      flash[:notice] = "Event-Quelle aktualisiert"
    else
      flash[:notice] = "Event-Quelle konnte nicht aktualisiert werden"
    end
    redirect_to event_sources_path
  end
  
  
  def destroy
    @event_source.destroy
    flash[:notice] = "Event-Quelle gelöscht"
    redirect_to event_sources_path
  end

private
  def load_event_source
    @event_source = EventSource.find(params[:id])
  end
  
  
end
