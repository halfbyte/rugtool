# This is the place for all your importer tasks.
# To activate an importer in the production system, you'll have to add the task
# to one of the scheduled-Tasks in scheduled.rake

namespace :events do
  
  desc "imports events from venteria"
  task :import_venteria do
    Rake::Task['environment'].invoke
    Event.import_from_feed("http://venteria.com/groups/23-Rails-is-love-baby-.atom") do |event, item|
      doc = Hpricot(item.content)
      dtstart =  (doc / ".dtstart").first[:title]
      event.starts_at = Time.parse(dtstart)
    end
  end
  
  
  #
  # add your own event importer tasks here
  #
  
end

namespace :feeds do
  desc "import news feed from tumblr"
  task :import_tumblr_news do
    Rake::Task['environment'].invoke
    FeedCache.read_feed('http://rubyonrails-ug-de.tumblr.com/rss', 'ug-tumble')
  end
end