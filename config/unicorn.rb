working_dir = File.expand_path(File.dirname(__FILE__))
rails_env = ENV['RAILS_ENV'] || 'production'

worker_processes 4
timeout 30
pid working_dir + '/tmp/pids/unicorn.pid'
listen working_dir '/tmp/sockets/unicorn.sock', :backlog => 64
