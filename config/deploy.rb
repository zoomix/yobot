set :application, "cruncher-bot"

set :repository,  "git@github.com:crunchy/yobot.git"
set :scm, "git"
set :branch, "master"

set :user, "cruncher"
set :use_sudo, false
set :port, 22345

default_run_options[:pty] = true  # Must be set for the password prompt from git to work

role :app, "ci-01.crunchconnect.com"                          # This may be the same as your `Web` server
set :deploy_to, "/home/cruncher/#{application}"
#set :deploy_via, :copy
#set :environment, "production"

namespace :deploy do
  task :start do
    sudo "start crunch-bot"
  end
  task :stop do
    sudo "stop crunch-bot"
  end
  task :restart do
    # prevents step from failing if bot isn't running
    sudo "stop crunch-bot ; sudo start crunch-bot"
  end
end

#
