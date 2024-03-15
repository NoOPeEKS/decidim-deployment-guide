# How to deploy a Decidim instance

## Build and run docker containers

```bash
sudo docker-compose build
sudo docker-compose up
```

## Create system admin user

```bash
sudo docker exec -it decidim-tutorial_decidim_1 /bin/bash
bundle exec rails console
user = Decidim::System::Admin.new(email: 'system@example.org', password: 'decidim123456789', password_confirmation: 'decidim123456789')
user.save!
exit
```

## Create new organization

Head to `http://localhost:8080`, wait for it to redirect to `http://localhost:8080/system/admins/sign_in` and log in with the system user you have created.
Fill the form to create a new organization and configure your smtp server. If you do not do so, you won't have any way to create an admin for your organization.

## Enjoy your webpage

As of now, you should be able to reach `http://localhost:8080` and it should redirect to your main organization page.
