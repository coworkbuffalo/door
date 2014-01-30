# config/unicorn.rb
worker_processes 3
timeout 15
preload_app true

pid_path = "tmp/pids/unicorn.pid"
pid pid_path

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
  old_pid_path = "#{pid_path}.oldbin"
  if File.exists?(old_pid_path) && server.pid != old_pid_path
    begin
      Process.kill("QUIT", File.read(old_pid_path).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
