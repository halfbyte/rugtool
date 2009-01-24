namespace :events do
  
  desc "imports events from venteria"
  task :import_venteria do
    Rake::Task['environment'].invoke
    Event.import_from_venteria_feed("feed://venteria.com/groups/23-Rails-is-love-baby-.atom")
  end
  
  
end