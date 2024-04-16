#!/bin/sh
set -e
# This creates database tables through migrations
# and installs needed gems for smtp configuration.
bundle exec rails db:migrate
bundle add delayed_job_active_record
bundle add daemons
bundle install
rails generate delayed_job:active_record
rake db:migrate
sleep 5;
RAILS_ENV=production /code/bin/delayed_job restart
exec "$@"
