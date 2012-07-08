set :application, 'metajury'
set :scm,         :git
set :repository,  'git@github.com:Emerson/Metajury.git'
set :deploy_via,  :remote_cache
set :user,        'metajury'
set :use_sudo,    false
set :keep_releases, 3
set :normalize_asset_timestamps, false # Removes No such file/directory warnings.


namespace :deploy do

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :production do
    set :application, 'metajury.com'
    set :rails_env,   'production'
    set :domain,      "metajury.com"
    set :deploy_to,   "/home/metajury/#{application}"
    set :branch,      'master'
    role :app,  domain
    role :web,  domain
    role :db,   domain, :primary => true
  end

  task :apply_configs, :roles => :app do
    run "cp #{release_path}/config/environments/#{rails_env}/database.yml #{release_path}/config/database.yml"
    run "cp #{release_path}/config/environments/#{rails_env}/settings.yml #{release_path}/config/settings.yml"
  end

  task :create_branch_file, :roles => :app, :except => { :no_symlink => true } do
    run "echo #{branch} > #{release_path}/config/.git_branch"
  end

end

after 'deploy:update_code', 'deploy:apply_configs'
after 'deploy:update_code', 'deploy:create_branch_file'
after 'deploy', 'deploy:cleanup'