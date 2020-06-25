# avenga/wordpress

![pulls](https://img.shields.io/docker/pulls/avenga/wordpress.svg)
![size](https://images.microbadger.com/badges/image/avenga/wordpress.svg)
[![commit](https://images.microbadger.com/badges/commit/avenga/sloppy.svg)](https://microbadger.com/images/avenga/wordpress)

## Usage

* Create a `.htaccess` and a `setup.sh` file in your project.
* Create a `plugins` and/or a `themes` directory in your project.
* Create a `Dockerfile` in your project with the content:

```
FROM avenga/wordpress
COPY plugins /var/files/plugins
COPY themes /var/files/themes
# For every plugin/theme in your project do:
RUN ln -sf /var/files/themes/<your-theme> /usr/src/wordpress/wp-content/themes/<your-theme>;\
    ln -sf /var/files/plugins/<your-plugin> /usr/src/wordpress/wp-content/plugins/<your-plugin>
```

It will copy your `.htaccess` file and your `setup.sh` file in the docker image
when you build it. In your `setup.sh` you can use `wp` CLI to install other plugins/themes for example.

### Configuration

Following environment variables are available:

* `WORDPRESS_PLUGIN_LIST`: A comma seperated list of plugins that should be
  installed. Default: empty
* `WORDPRESS_THEME_LIST`: A comma seperated list of themes that should be
  installed. Default: empty

```bash
# General:
WORDPRESS_DOMAIN
WORDPRESS_URL
WORDPRESS_TITLE=""
WORDPRESS_DESCRIPTION=""
WORDPRESS_ADMIN_EMAIL
WORDPRESS_ADMIN_PASSWORD

# Database:
WORDPRESS_DB_HOST
WORDPRESS_DB_NAME
WORDPRESS_DB_USER
WORDPRESS_DB_PASSWORD

# Debugging:
WORDPRESS_DEBUG

# Authentication:
# Change these to different unique phrases!
# You can generate these using https://api.wordpress.org/secret-key/1.1/salt/
# You can change these at any point in time to invalidate all
# existing cookies. This will force all users to have to log in again.
WORDPRESS_AUTH_KEY
WORDPRESS_SECURE_AUTH_KEY
WORDPRESS_LOGGED_IN_KEY
WORDPRESS_NONCE_KEY
WORDPRESS_AUTH_SALT
WORDPRESS_SECURE_AUTH_SALT
WORDPRESS_LOGGED_IN_SALT
WORDPRESS_NONCE_SALT

```

Check the `example` dir how to do it.

## Test

Setup:
```bash
docker-compose up --build --force-recreate
```

Go to http://localhost:8008 to play around with your wordpress installation.

Teardown:
```bash
docker-compose down -v --remove-orphans
```
