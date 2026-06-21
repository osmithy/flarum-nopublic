#!/bin/sh
set -e

# Start PHP-FPM in background
php-fpm &

# Start nginx in foreground
nginx -g "daemon off;"