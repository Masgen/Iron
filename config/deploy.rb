require "bundler/capistrano"

server "50.57.122.69", :web, :app, :db, primary: true

set :application, "irond"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:Masgen/Iron.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/config/environments"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/environments/production.clean.rb"), "#{shared_path}/config/environments/production.rb"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/environments/production.rb #{release_path}/config/environments/production.rb"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
  
  desc "Link up Sphinx's indexes."
  task :symlink_sphinx_indexes, :roles => [:app] do
    run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end

  task :activate_sphinx, :roles => [:app] do
    symlink_sphinx_indexes
    thinking_sphinx.configure
    thinking_sphinx.start
  end

  before 'deploy:update_code', 'thinking_sphinx:stop'
  after 'deploy:update_code', 'deploy:activate_sphinx'
end

require 'thinking_sphinx/deploy/capistrano'

# Thinking Sphinx typing shortcuts
namespace :ts do
  task :conf do
    thinking_sphinx.configure
  end
  task :in do
    thinking_sphinx.index
  end
  task :start do
    thinking_sphinx.start
  end
  task :stop do
    thinking_sphinx.stop
  end
  task :restart do
    thinking_sphinx.restart
  end
  task :rebuild do
    thinking_sphinx.rebuild
  end
end