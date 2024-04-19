#!/bin/sh
set -e

generate_delayed_job() {
  if ! rails generate delayed_job:active_record; then
      echo "Warning: Could not generate delayed_job:active_record. Already applied."
  fi
  if ! rake db:migrate; then
      echo "Warning: Database migration failed. Already applied."
  fi
}

install_gems() {
  ######## ADD HERE YOUR GEMS ########
  bundle add decidim-conferences
  bundle add decidim-design
  bundle add decidim-initiatives
  bundle add decidim-templates
  bundle add decidim-comments
  bundle add decidim-meetings
  ####################################

  ####### THESE ARE MANDATORY #########
  bundle add delayed_job_active_record
  bundle add daemons
  bundle install
  ####################################
}
exec_commands() {
  #### UNCOMMENT THESE STATEMENTS IF CONTAINER INSTANTIATION FOR THE FIRST TIME ####
  ############### COMMENT THEM IF YOU HAVE ALREADY RUN THEM ONCE ###################
  #if ! bundle exec rails decidim_conferences:install:migrations; then
      #echo "Warning: decidim_conferences migrations already applied"
  #fi
  #if ! bundle exec rails decidim_initiatives:install:migrations; then
      #echo "Warning: decidim_initiatives migrations already applied"
  #fi
  #################################################################################
  npm install
  bundle exec rails db:migrate
  bundle exec rake assets:precompile
}
install_gems
exec_commands
generate_delayed_job
sleep 5;
RAILS_ENV=production /code/bin/delayed_job restart
exec "$@"
