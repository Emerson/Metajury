require "rvm/capistrano"  
require 'bundler/capistrano'

default_run_options[:pty] = true

set :application, 'metajury.com'
set :scm,         :git
set :repository,  'https://github.com/Emerson/Metajury.git'
set :user,        'metajury'
set :use_sudo,    false
set :keep_releases, 3
set :normalize_asset_timestamps, false # Removes No such file/directory warnings.
set :deploy_to,   "/home/#{user}/#{application}"
set :rvm_ruby_string, '1.9.3@metajury'
set :rvm_bin_path, "/usr/local/rvm/bin"
set :rvm_path,  "/usr/local/rvm"

# Unicorn
set :unicorn_binary, "unicorn"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid,    "#{current_path}/tmp/pids/unicorn.pid"

namespace :unicorn do
  desc "start unicorn"
  task :start, :roles => :app, :except => {:no_release => true} do
    run "cd #{current_path} && bundle exec #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end
  desc "stop unicorn"
  task :stop, :roles => :app, :except => {:no_release => true} do
    run "#{try_sudo} kill `cat #{unicorn_pid}`"
  end
  desc "unicorn reload"
  task :reload, :roles => :app, :except => {:no_release => true} do
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  end
  desc "graceful stop unicorn"
  task :graceful_stop, :roles => :app, :except => {:no_release => true} do
    run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  end
  desc "restart unicorn"
  task :restart, :roles => :app, :except => {:no_release => true} do
    # stop
    # start
  end

  after "deploy:restart", "unicorn:restart"
end


task :production do
  set :application, 'metajury.com'
  set :rails_env,   'production'
  set :domain,      "metajury.com"
  set :deploy_to,   "/home/#{user}/#{application}"
  set :branch,      'master'
  role :app,  domain
  role :web,  domain
  role :db,   domain, :primary => true
end


namespace :deploy do

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end


  task :apply_configs, :roles => :app do
    run "cp /home/#{user}/#{application}/shared/configs/database.yml #{release_path}/config/database.yml"
    run "cp /home/#{user}/#{application}/shared/configs/application_settings.yml #{release_path}/config/application_settings.yml"
    run "cp /home/#{user}/#{application}/shared/configs/email.yml #{release_path}/config/email.yml"  
  end

  task :create_branch_file, :roles => :app, :except => { :no_symlink => true } do
    run "echo #{branch} > #{release_path}/config/.git_branch"
  end

  task :create_dirs, :roles => :app do
    run "mkdir #{release_path}/tmp/sockets"
  end

end

before 'deploy:setup', 'rvm:install_ruby'
after 'deploy:update_code', 'deploy:apply_configs'
after 'deploy:update_code', 'deploy:create_branch_file'
after 'deploy:update_code', 'deploy:create_dirs'
after 'deploy', 'deploy:cleanup'