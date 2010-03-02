# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion


set :application, "rugtool"
set :domain,      "headflash.com"
set :repository,  "git@github.com:halfbyte/rugtool.git"
set :use_sudo,    false
set :deploy_to,   "/srv/www/vhosts/beta.rubyonrails-ug.de"
set :scm,         "git"

set :user, "jan"

role :app, "headflash.com"
role :web, "headflash.com"
role :db,  "headflash.com", :primary => true

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

after 'deploy:update_code', :set_symlinks

task :set_symlinks do
  run "ln -f -s #{shared_path}/config/recaptcha.yml #{release_path}/config/recaptcha.yml"
  run "ln -f -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  run "ln -f -s #{shared_path}/wiki/data #{release_path}/public/wiki/data"
  run "ln -f -s #{shared_path}/wiki/conf #{release_path}/public/wiki/conf"
end
