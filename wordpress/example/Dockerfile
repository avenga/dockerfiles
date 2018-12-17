FROM 7val/wordpress:5
COPY plugins /var/files/plugins
COPY themes /var/files/themes
# symlink read-only files into the /var/www/html volume
# symlinks get copied from the src directory;
# creating them directly doesn't work thanks to https://github.com/moby/moby/issues/3639
RUN ln -sf /var/files/themes/test /usr/src/wordpress/wp-content/themes/test;\
    ln -sf /var/files/plugins/myplugin /usr/src/wordpress/wp-content/plugins/myplugin
