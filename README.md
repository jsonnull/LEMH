# Wordpress on nginx + HHVM + MySQL
wp-lemh is a docker build that makes it easy to spin up a blazing fast Wordpress deployment using the LEMH stack.

Over time I will update this with tutorials on developing with Wordpress in a containerized LEMH stack such as this.

## Recommended Usage

Use docker-compose to declare the environment variables and start the containers.

First, edit `docker-compose.yml`:
```
# http://docs.docker.com/compose/yml/
web:
  image: jsonnull/wp-lemh
  links:
   - db
  ports:
   - "80:80"
  environment:
   - DB_USER=root
   - DB_PASSWORD=test
   - DB_NAME=wordpress
db:
  image: mariadb:10.1.2
  ports:
   - "3306:3306"
  environment:
   - MYSQL_ROOT_PASSWORD=test
   - MYSQL_DATABASE=wordpress
```

Then run `docker-compose up -d` to start the daemonized containers.

See https://docs.docker.com/compose/install/ for info on how to install and use docker-compose.

## Alternate Usage

Just run two containers with docker.

```
docker run -d --name db_1 -e "MYSQL_DATABASE=wordpress" -e "MYSQL_ROOT_PASSWORD=test" -p 3306:3306 mariadb:10.1.2
docker run -d --name web_1 --link db_1:db_1 -e "DB_USER=root" -e "DB_PASSWORD=test" -p 80:80 jsonnull/wp-lemh
```
