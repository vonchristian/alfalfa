#!/usr/bin/env puma
workers 4

environment ENV['RAILS_ENV'] || 'production'

daemonize true

pidfile "/var/www/alfalfa-construction/shared/tmp/pids/puma.pid"
stdout_redirect "/var/www/alfalfa-construction/shared/tmp/log/stdout", "/var/www/alfalfa-construction/shared/tmp/log/stderr"

threads 0, 16

bind "unix:///var/www/alfalfa-construction/shared/tmp/sockets/puma.sock"
activate_control_app

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
end
