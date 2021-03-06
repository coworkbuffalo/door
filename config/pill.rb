RAILS_ROOT = "/Users/qrush/Apps/door"

Bluepill.application("door", :log_file => File.join(RAILS_ROOT, 'log', 'bluepill.log')) do |app|
  app.process("unicorn") do |process|
    process.pid_file = File.join(RAILS_ROOT, 'tmp', 'pids', 'unicorn.pid')
    process.working_dir = RAILS_ROOT

    process.start_command = "/Users/qrush/.rvm/bin/door_bundle exec unicorn -Dc config/unicorn.rb -E production -l 80"
    process.stop_command = "kill -QUIT {{PID}}"
    process.restart_command = "kill -USR2 {{PID}}"

    process.start_grace_time = 8.seconds
    process.stop_grace_time = 5.seconds
    process.restart_grace_time = 13.seconds

    process.checks :running_time, :every => 10.minutes, :below => 30.minutes

    process.monitor_children do |child_process|
      child_process.stop_command = "kill -QUIT {{PID}}"

      child_process.checks :mem_usage, :every => 10.seconds, :below => 150.megabytes, :times => [3,4], :fires => :stop
      child_process.checks :cpu_usage, :every => 10.seconds, :below => 20, :times => [3,4], :fires => :stop
    end
  end
end
