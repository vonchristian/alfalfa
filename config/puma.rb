# #!/usr/bin/env puma

# environment 'production'
# threads 2, 64
# workers 4

# app_name = "alfalfa-construction"
# application_path = "/var/www/#{app_name}"
# directory "#{application_path}/current"

# pidfile "#{application_path}/shared/tmp/pids/puma.pid"
# state_path "#{application_path}/shared/tmp/sockets/puma.state"
# stdout_redirect "#{application_path}/shared/log/puma.stdout.log", "#{application_path}/shared/log/puma.stderr.log"
# bind "unix://#{application_path}/shared/tmp/sockets/#{app_name}.sock"
# activate_control_app "unix://#{application_path}/shared/tmp/sockets/pumactl.sock"

# daemonize true
# on_restart do
#   puts 'On restart...'
# end
# preload_app!
