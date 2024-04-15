#!/bin/sh

`sudo docker exec container_decidim bundle exec rails runner "user = Decidim::System::Admin.new(email: 'system@example.org', password: 'decidim123456789', password_confirmation: 'decidim123456789'); user.save!;"`
