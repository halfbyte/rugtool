namespace :scheduled do
  desc "this task will be executed every hour in the production system"
  task :hourly do
    Rake::Task['events:import_venteria'].invoke
    # add your own task calls here for very active content
    Rake::Task['feeds:import_tumblr_news'].invoke
  end

  desc "this task will be executed every morning in the production system"
  task :daily do
    # add your own task calls here for daily things - will be executed
    # every early morning in the production system
    
  end
  
  
  
end