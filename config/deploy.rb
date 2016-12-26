set :application, "getyalla"
set :repo_url, "git@gitlab.com:sarupbanskota/yalla-backend.git"

set :deploy_to, '/home/sarup/getyalla'

append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"
