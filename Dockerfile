FROM php:8.3-fpm-alpine

# Install build dependencies first
RUN apk add --no-cache \
    oniguruma-dev

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring

# Install runtime dependencies
RUN apk add --no-cache \
    nginx \
    curl \
    git \
    composer \
    mysql-client

# Install Flarum
WORKDIR /app
RUN composer create-project flarum/flarum . --stability=beta --ignore-platform-req=ext-pdo

# Configure nginx
RUN mkdir -p /etc/nginx/conf.d
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]