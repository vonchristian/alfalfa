#!/usr/bin/env puma

environment ENV['RAILS_ENV'] || 'production'

daemonize true

pidfile "/var/www/alfalfa-construction/shared/tmp/pids/puma.pid"
stdout_redirect "/var/www/alfalfa-construction/shared/tmp/log/stdout", "/var/www/alfalfa-construction/shared/tmp/log/stderr"

threads 0, 16

bind "unix:///var/www/alfalfa-construction/shared/tmp/sockets/puma.sock"
