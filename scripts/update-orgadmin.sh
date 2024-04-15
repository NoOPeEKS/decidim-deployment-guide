#!/bin/sh

CONTAINERID=$1

sudo docker exec $CONTAINERID bundle exec rails runner "user = Decidim::User.find_by(id: 2); user.admin = true; user.admin_terms_accepted_at = '2024-03-15 12:10:08'; user.save!;"
