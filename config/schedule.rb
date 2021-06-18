rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
set :output, "log/cron.log"

# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

every 10.minutes do
  rake "reset_guestdata"
end
