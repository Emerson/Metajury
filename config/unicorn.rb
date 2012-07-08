# Path Setup
APP_PATH = "/home/metajury/metajury.com/current"
working_dir APP_PATH

# General Unicorn Flags
rails_env = ENV['RAILS_ENV'] || 'production'
worker_processes 4
timeout 30

# Socket and Pid Location
pid working_dir + '/tmp/pids/unicorn.pid'
listen working_dir '/tmp/sockets/unicorn.sock', :backlog => 64

# Preload Setup
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
