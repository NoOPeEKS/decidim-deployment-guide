#!/bin/sh

# This script is only needed for previous versions such as 0.24.0. For actual version 0.28.0 it is not needed at all
CONTAINERID=$1

sudo docker exec $CONTAINERID bundle exec rails runner "user = Decidim::User.find_by(id: 2); user.admin = true; user.admin_terms_accepted_at = '2024-03-15 12:10:08'; user.save!;"
