#!/bin/bash

wp theme install --activate understrap
wp plugin install --activate tinymce-advanced
wp theme delete twentyfifteen twentysixteen twentyseventeen
wp theme activate test
