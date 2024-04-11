FROM nginx
RUN apt-get update -qq && apt-get -y install apache2-utils
COPY nginx.conf /tmp/docker.nginx
COPY selfsigned.crt /etc/ssl/certs/selfsigned.crt
COPY selfsigned.key /etc/ssl/certs/selfsigned.key
RUN cat /tmp/docker.nginx > /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
