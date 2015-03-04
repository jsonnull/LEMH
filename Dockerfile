# This is a comment
FROM ubuntu:14.04
MAINTAINER Jason Nall <jsonnull@gmail.com>

# System setup
RUN apt-get update

# Basic requirements & Wordpress requirements
RUN apt-get -y install nginx php5-mysql php-apc php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl wget curl unzip

# Install HHVM
#   https://github.com/facebook/hhvm/wiki/Prebuilt-packages-on-Ubuntu-14.04
RUN curl http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add - && \
    echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list && \
    apt-get update && apt-get install -y hhvm

# Configure nginx
COPY ./nginx-site.conf /etc/nginx/sites-available/default
RUN /usr/share/hhvm/install_fastcgi.sh && \
    echo "daemon off;" >> /etc/nginx/nginx.conf

# Install supervisor
RUN apt-get install -y supervisor && \
    mkdir -p /var/log/supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf 

# Install Wordpress 
RUN mkdir /var/www &&\
    cd /var/www &&\
    wget http://wordpress.org/latest.tar.gz &&\
    tar -xzvf latest.tar.gz &&\
    chown -vR :www-data /var/www/wordpress/
COPY ./wp-config.php /var/www/wordpress/wp-config.php 

# Define mountable directories.
VOLUME "/var/www"

CMD ["/usr/bin/supervisord"]