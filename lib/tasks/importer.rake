namespace :events do
  
  desc "imports events from venteria"
  task :import_venteria do
    Rake::Task['environment'].invoke
    Event.import_from_venteria_feed("http://venteria.com/groups/23-Rails-is-love-baby-.atom") do |event, item|
      doc = Hpricot(item.content)
      dtstart =  (doc / ".dtstart").first[:title]
      event.starts_at = Time.parse(dtstart)
    end
  end
  
  
  
end