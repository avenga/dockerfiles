#!/bin/bash

set -eux

URL=${WORDPRESS_DOMAIN:-localhost}
OVERWRITE=${WORDPRESS_OVERWRITE:-"false"}
REFRESH_ONLY=${WORDPRESS_REFRESH_ONLY:-"false"}

# Defaults for optional fields:
WORDPRESS_TITLE=${WORDPRESS_TITLE:-""}
WORDPRESS_DESCRIPTION=${WORDPRESS_DESCRIPTION:-""}

# test first if WordPress is already installed
# if so, skip everything else
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

wp option update blogdescription "${WORDPRESS_DESCRIPTION}"

/bin/bash -c "/setup.sh"

# call original command
apache2-foreground
