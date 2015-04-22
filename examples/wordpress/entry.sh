if [ ! -d "/var/www/wp-content" ]; then
    cd /var/www &&\
    wget https://wordpress.org/wordpress-4.1.2.tar.gz &&\
    tar -xzvf latest.tar.gz &&\
    mv wordpress/* ./ &&\
    rm -r wordpress
fi