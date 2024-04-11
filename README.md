# Deploying a Decidim Instance

## Generating selfsigned certificates
```bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./selfsigned.key -out ./selfsigned.crt
```

## Building and Running Docker Containers

```bash
sudo docker-compose build
sudo docker-compose up
```

## Creating a System Admin User

```bash
sudo docker exec -it decidim-tutorial_decidim_1 /bin/bash # Connect to the running Decidim instance container
bundle exec rails console # Execute Ruby on Rails console
user = Decidim::System::Admin.new(email: 'system@example.org', password: 'decidim123456789', password_confirmation: 'decidim123456789') # Create a new system user with your preferred credentials.
user.save! # Save the new user permanently into the database
exit
```

## Creating a New Organization

Visit `https://localhost:8080`, and log in with the system user you have created. Fill the form with your organization's data and set `localhost` as the host.

You now have two options:

- You have a functional SMTP server.
- Youou do not have an SMTP server or it does not function well.

### Option 1: SMTP Server

If you have a functioning SMTP server, click on advanced settings and set your server's information. Click on save and send email, then go to your email and follow the steps to set up your administrator account. You can now visit `http://localhost:8080` and see your webpage. Customize it as you please!

### Option 2: No SMTP Server

If you do not have an SMTP server set up, you can create a user and manually update its privileges to gain admin access through the database.

1. Register only one normal user from within `http://localhost:8080`. This user will be your organization's webpage admin.

2. Execute the following commands:

```bash
sudo docker exec -it decidim-tutorial_decidim_1 /bin/bash # Connect to the Decidim instance container
bundle exec rails console # Execute Ruby on Rails console
user = Decidim::User.find_by(id: 1) # Select the first user in the database, which is the one you created earlier
user.admin = true # Set its admin privileges to true
user.admin_terms_accepted_at = "2024-03-15 12:10:08" # Set a date for accepting admin terms
user.save! # Permanently update the user in the database
exit
```

3. Navigate to `https://localhost:8080/admin` and log in as the user you just updated.
4. Customize the website to your preferences!
