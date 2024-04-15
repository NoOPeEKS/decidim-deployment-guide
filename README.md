# Deploying a Decidim Instance

## Generating selfsigned certificates
If you haven't bought a domain, you can still use the application through self-signed SSL certificates, but browsers will raise a warning.
```bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./selfsigned.key -out ./selfsigned.crt
```
This command should generate your self-signed certificate and private key and move it to the decidim-tutorial directory. \
Then, open nginx.conf and add under `listen 443 ssl;` the following lines:
- `ssl_certificate /etc/ssl/certs/selfsigned.crt;`
- `ssl_certificate_key /etc/ssl/certs/selfsigned.key;` \
Then, open nginx.Dockerfile and modify it so that the copy commands look like this:
- `COPY nginx.conf /tmp/docker.nginx`
- `COPY selfsigned.crt /etc/ssl/certs/selfsigned.crt`
- `COPY selfsigned.key /etc/ssl/certs/selfsigned.key`

## Generating a certificate for your specific domain using Let's Encrypt
```bash
sudo certbot certonly --standalone -d subdomain.domain.com -v
cp /etc/letsencrypt/live/subdomain.domain.com/fullchain.pem .
cp /etc/letsencrypt/live/subdomain.domain.com/privkey.pem .
```
These commands should generate your certificate and private key and move it to the decidim-tutorial directory. \
Then, open nginx.conf and add under `listen 443 ssl;` the following lines:
- `ssl_certificate /etc/ssl/certs/fullchain.pem;`
- `ssl_certificate_key /etc/ssl/certs/privkey.pem;` \
Then, open nginx.Dockerfile and modify it so that the copy commands look like this:
- `COPY nginx.conf /tmp/docker.nginx`
- `COPY fullchain.pem /etc/ssl/certs/fullchain.pem`
- `COPY privkey.pem /etc/ssl/certs/privkey.pem`

## Creating a Docker Swarm cluster and deployng decidim stack
These commands will create a docker swarm cluster to orchestrate and manage the services needed to run decidim and its services.
```bash
sudo docker swarm init
sudo docker-compose build
sudo docker stack deploy --detach=false -c docker-compose.yml decidim-tutorial
```

## Creating a System Admin User
To create a System Admin User, you only need to execute a single script and pass it its credentials:
```bash
cd scripts
sudo docker ps # This will show every container with its id, name, image_name, etc
./create-sysadmin.sh <DECIDIM_CONTAINER_ID> <EMAIL> <PASSWORD>
```

## Creating a New Organization

Visit `https://localhost:443`, and log in with the system user you have created. Fill the form with your organization's data and set `localhost` as the host.

You now have two options:

- You have a functional SMTP server.
- Youou do not have an SMTP server or it does not function well.

### Option 1: SMTP Server

If you have a functioning SMTP server, click on advanced settings and set your server's information. Click on save and send email, then go to your email and follow the steps to set up your administrator account. You can now visit `https://localhost:443` and see your webpage. Customize it as you please!

### Option 2: No SMTP Server

If you do not have an SMTP server set up, you can create a user and manually update its privileges to gain admin access through the database.

1. Register ONLY ONE normal user (must be the first user apart from sysadmin) from within `https://localhost:443`. This user will be your organization's webpage admin. Otherwise, the script will not work properly.

2. Execute the following commands:

```bash
cd scripts
sudo docker ps # This will output every container's info including container id
./update-orgadmin.sh <CONTAINER_ID>
```

3. Navigate to `https://localhost:443/admin` and log in as the user you just updated.
4. Customize the website to your preferences!
