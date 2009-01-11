class PlanetFeedsController < ApplicationController
  before_filter
  
  # GET /planet_feeds
  # GET /planet_feeds.xml
  def index
    @title = "Alle Planet-Feeds"
    @planet_feeds = PlanetFeed.accepted.find(:all)
    @new_planet_feeds = PlanetFeed.not_accepted.find(:all)

    @planet_feed = PlanetFeed.new
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @planet_feeds }
    end
  end

  # GET /planet_feeds/1
  # GET /planet_feeds/1.xml
  def show
    @planet_feed = PlanetFeed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @planet_feed }
    end
  end

  # GET /planet_feeds/new
  # GET /planet_feeds/new.xml
  def new
    @planet_feed = PlanetFeed.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @planet_feed }
    end
  end

  # GET /planet_feeds/1/edit
  def edit
    @planet_feed = PlanetFeed.find(params[:id])
  end

  # POST /planet_feeds
  # POST /planet_feeds.xml
  def create
    @planet_feed = PlanetFeed.new(params[:planet_feed])

    respond_to do |format|
      if @planet_feed.save
        flash[:notice] = 'PlanetFeed was successfully created.'
        format.html { redirect_to(planet_feeds_path) }
        format.xml  { render :xml => @planet_feed, :status => :created, :location => @planet_feed }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @planet_feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /planet_feeds/1
  # PUT /planet_feeds/1.xml
  def update
    @planet_feed = PlanetFeed.find(params[:id])

    respond_to do |format|
      if @planet_feed.update_attributes(params[:planet_feed])
        flash[:notice] = 'PlanetFeed was successfully updated.'
        format.html { redirect_to(planet_feeds_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @planet_feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /planet_feeds/1
  # DELETE /planet_feeds/1.xml
  def destroy
    @planet_feed = PlanetFeed.find(params[:id])
    @planet_feed.destroy

    respond_to do |format|
      format.html { redirect_to(planet_feeds_url) }
      format.xml  { head :ok }
    end
  end
end
