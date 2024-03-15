FROM nginx
RUN apt-get update -qq && apt-get -y install apache2-utils
COPY nginx.conf /tmp/docker.nginx
RUN cat /tmp/docker.nginx > /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
