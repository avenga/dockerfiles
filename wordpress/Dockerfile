FROM wordpress:latest AS release

# Add sudo in order to run wp-cli as the www-data user
RUN apt-get update && apt-get install -y sudo less

# Add WP-CLI
RUN curl -o /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
COPY wp-su.sh /bin/wp
RUN chmod +x /bin/wp-cli.phar /bin/wp

# Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add custom entrypoint, called by existing entrypoint
# name it to match apache2-foreground, so that it can still
# configure permissions for running apache2
COPY apache2-init.sh /usr/local/bin
RUN chmod +x /usr/local/bin/apache2-init.sh

ONBUILD COPY .htaccess /usr/src/wordpress/.htaccess
COPY wp-config.php /usr/src/wordpress/wp-config.php

RUN mkdir -p /var/files
ONBUILD COPY setup.sh /setup.sh

ENTRYPOINT docker-entrypoint.sh apache2-init.sh
