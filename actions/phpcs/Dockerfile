FROM composer:latest

# Install some PHP extensions
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    php-sockets \
    php-intl \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
