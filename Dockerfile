FROM centos:6
MAINTAINER Matt Becker
  

###############################################
# Install OS Utilities and Language packages  #
###############################################
#
RUN yum -y install epel-release
RUN yum -y install \
  curl \
  git \
  nginx \
  php-fpm \
  openssl \
  php-devel \
  php-gd \
  php-mcrypt* \
  php-mysql \
  php-pear \
  tar \
  unzip  \
  wget \
  which \
  mysql-server \
  xterm

RUN yum -y install \
  bzip2-devel  \
  openssl-devel \
  sqlite-devel

# add nginx conf
ADD nginx.conf /etc/nginx/nginx.conf
ADD setup.sh /root/setup.sh
ADD www.conf /etc/php-fpm.d/www.conf
RUN chmod +x /root/setup.sh

# Make sure php-fpm and nginx are set up correctly
RUN sed 's|listen = 127.0.0.1:9000|listen = /var/run/php-fpm.sock|g' /etc/php-fpm.d/www.conf


RUN yum clean all


############
# Startup  #
############
#
EXPOSE 8888:80
EXPOSE 8080:8080
CMD tail -f /var/log/lastlog && nginx && php-fpm
