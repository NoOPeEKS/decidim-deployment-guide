# How to deploy a Decidim instance

## Build and run docker containers

```bash
sudo docker-compose build
sudo docker-compose up
```

## Create system admin user

```bash
sudo docker exec -it decidim-tutorial_decidim_1 /bin/bash # Connect to the running Decidim instance container
bundle exec rails console # Execute Ruby on Rails console
user = Decidim::System::Admin.new(email: 'system@example.org', password: 'decidim123456789', password_confirmation: 'decidim123456789') # Create a new system user with your preferred credentials.
user.save! # Save the new user permanently into database
exit
```

## Create new organization

Head to `http://localhost:8080`, wait for it to redirect to `http://localhost:8080/system/admins/sign_in` and log in with the system user you have created.
Fill the form with your organization's data and put `localhost` on host.
There is now two options:

- You have got a functional SMTP server
- You do not have an SMTP server or it does not function well.

### SMTP server

If you have a functioning smtp server, click on advanced settings and set your server's information.
Click on save and send email, then go to your email and follow the steps to set up your administrator account.
You can now visit `http://localhost:8080` and see your webpage. Customize it at your please!

### No SMTP server

If you do not have an smtp server set up, you can do it the hard and raw way. This means creating a user and manually updating its privileges to get admin access through the database.

1. First, register only one normal user from within `http://localhost:8080`. This is now your organization webpage.

2. Follow these commands:

```bash
sudo docker exec -it decidim-tutorial_decidim_1 /bin/bash # This connects to the Decidim instance container
bundle exec rails console # Execute Ruby on Rails console
user = Decidim::User.find_by(id: 1) # Select first user on database. This will be the one you created earlier
user.admin = true # Set its admin privileges to true
user.admin_terms_accepted_at = "2024-03-15 12:10:08" # Set a date of accepting admin terms
user.save! # Update permanently the user on database
exit
```

3. Navigate to `http://localhost:8080/admin` and log in as the user you just updated.
4. Customize the website as you please!
