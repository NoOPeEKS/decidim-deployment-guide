#!/bin/sh

CONTAINERID=$1
EMAIL=$2
PASSWORD=$3

sudo docker exec $CONTAINERID bundle exec rails runner "user = Decidim::System::Admin.new(email: '$EMAIL', password: '$PASSWORD', password_confirmation: '$PASSWORD'); user.save!;"
