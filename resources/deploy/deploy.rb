# config valid only for current version of Capistrano
lock '3.4.0'

set :application, '{project}'
set :ssh_options, {forward_agent: true}

# Repository
set :scm, :git
set :repo_url, 'git@github.com:madewithlove/skeletor.git'
set :branch, 'develop'

# Logging
set :log_level, :debug
Airbrussh.configure do |config|
    config.command_output = true
    config.log_file = "storage/logs/capistrano.log"
end

# Plugins
set :composer_install_flags, '--prefer-dist --no-interaction --optimize-autoloader'
set :npm_flags, '--production --no-spin'

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('.env')
set :linked_dirs, fetch(:linked_dirs, []).push('public/uploads')

# Tasks
namespace :deploy do
    before :updated, "cache:install"
    before :updated, "maintenance:enable"
    before :updated, "application:cache"
    before :updated, "application:assets"
    before :finishing, "cache:clear"
    before :finishing, "maintenance:disable"
end
