FROM php:8.3-fpm-alpine

# Install dependencies
RUN apk add --no-cache \
    nginx \
    curl \
    git \
    composer \
    mysql-client \
    oniguruma-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring

# Install Flarum
WORKDIR /app
RUN composer create-project flarum/flarum . --stability=beta

# Configure nginx
RUN mkdir -p /etc/nginx/conf.d
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]