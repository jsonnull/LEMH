# Linux + nginx + MySQL + HHVM
**Lemhpress is a docker image that makes it easy to spin up a modern LEMH stack for PHP applications.** Wordpress on LEMH deployed to a 512mb DigitalOcean droplet serves pages scary fast and has a low memory footprint.

In addition, the repository is home to several supported configurations for PHP applications running on lemhpress.

App | Purpose | Version
----|---------|--------
Wordpress | blogging platform | 4.1.2
[esoTalk](https://github.com/esotalk/esoTalk) | forum software | [b2a1884](https://github.com/esotalk/esoTalk/commit/b2a1884fde967286a8c30c152e27b3fd4dfadad0)

To deploy one of these apps just clone this repo, navigate to the corresponding directory in `examples`, and run `docker-compose up`.

For info on how to install and use docker-compose see https://docs.docker.com/compose/install/.

## Running an app with docker-compose
Use docker-compose to declare the environment variables and start the containers.

First, edit `docker-compose.yml`. Here's a good starting point:

```
data:
  image: cogniteev/echo
  volumes:
   - /var/www
   - /var/lib/mysql

db:
  image: mariadb:latest
  ports:
   - "3306:3306"
  volumes_from:
   - data
  environment:
   - MYSQL_ROOT_PASSWORD=test
   - MYSQL_DATABASE=myapp

web:
  image: jsonnull/lemhpress
  links:
   - db
  ports:
   - "80:80"
  volumes_from:
   - data
  environment:
   - DB_USER=root
   - DB_PASSWORD=test
   - DB_NAME=myapp
```

Then run `docker-compose up -d` to start the daemonized containers. The server will attempt to serve PHP files from /var/wordpress.

### Alternate Usage

Just run two containers with docker.

```
docker run -d --name db_1 -e "MYSQL_DATABASE=wordpress" -e "MYSQL_ROOT_PASSWORD=test" -p 3306:3306 mariadb:latest
docker run -d --name web_1 --link db_1:db_1 -e "DB_USER=root" -e "DB_PASSWORD=test" -p 80:80 -v "/var/www" jsonnull/lemhpress
```