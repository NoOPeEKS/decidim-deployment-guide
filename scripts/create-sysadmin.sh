#!/bin/sh

EMAIL=$1
PASSWORD=$2

sudo docker exec container_decidim bundle exec rails runner "user = Decidim::System::Admin.new(email: '$EMAIL', password: '$PASSWORD', password_confirmation: '$PASSWORD'); user.save!;"
