#!/bin/bash

set -eux

URL=${WORDPRESS_DOMAIN:-localhost}
OVERWRITE=${WORDPRESS_OVERWRITE:-"false"}
REFRESH_ONLY=${WORDPRESS_REFRESH_ONLY:-"false"}
# Defaults for optional fields:
WORDPRESS_TITLE=${WORDPRESS_TITLE:-""}
WORDPRESS_DESCRIPTION=${WORDPRESS_DESCRIPTION:-""}
# bind variables
WORDPRESS_THEME_LIST="${WORDPRESS_THEME_LIST:-""}"
WORDPRESS_PLUGIN_LIST="${WORDPRESS_PLUGIN_LIST:-""}"

# Install WP themes from ENV var WORDPRESS_THEME_LIST
# $0
function wp_theme_install () {
    for theme in $WORDPRESS_THEME_LIST ; do
        if wp theme is-installed "$theme" ; then  wp theme install "$theme" ; fi
        if wp theme is-active "$theme" ; then wp theme activate "$theme" ; fi
    done
}
# Install WP plugins from ENV var WORDPRESS_PLUGIN_LIST
# $0
function wp_plugin_install () {
    for plugin in $WORDPRESS_PLUGIN_LIST ; do
        if wp plugin is-installed "$plugin" ; then  wp plugin install "$plugin" ; fi
        if wp plugin is-active "$plugin" ; then wp plugin activate "$plugin" ; fi
    done
}

# test first if WordPress is already installed
# if so, skip everything else
# FIXME This is quite confusing. The code should be cleaned up.
if wp core is-installed ; then
  /bin/bash -c "/setup.sh"
  if [ "$OVERWRITE" = "true" ] ; then
    if [ "$REFRESH_ONLY" = "true" ] ; then
      echo 'refresh only, not starting apache (again)'
    fi
    if [ "$REFRESH_ONLY" = "false" ] ; then
      echo 'starting apache in background'
      apache2-foreground &
    fi
    echo 'overwriting existing content'
    if [ "$REFRESH_ONLY" = "false" ] ; then
      echo 'done overwriting, waiting for apache'
      wait
      echo 'wait exited, lets quit'
    fi
    exit
  fi
  echo 'wp is already installed, starting apache'
  apache2-foreground
fi

# Install wordpress
wp core install \
  --url="$URL" \
  --title="${WORDPRESS_TITLE}" \
  --admin_user="admin" \
  --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
  --admin_email="${WORDPRESS_ADMIN_EMAIL}"

# Install themes if WORDPRESS_THEME_LIST is set
if [[ $WORDPRESS_THEME_LIST ]] ; then
    wp_theme_install
fi
# Install plugins if WORDPRESS_PLUGIN_LIST is set
if [[ $WORDPRESS_PLUGIN_LIST ]] ; then
    wp_plugin_install
fi

wp option update blogdescription "${WORDPRESS_DESCRIPTION}"

/bin/bash -c "/setup.sh"

# call original command
apache2-foreground
