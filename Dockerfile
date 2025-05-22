# syntax=docker/dockerfile:1
FROM php:8.4-cli
WORKDIR /app
RUN --mount=type=cache,target=/var/lib/apt --mount=type=tmpfs,target=/tmp/pear <<-EOF
    set -eux
    cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
    apt-get update
    apt-get dist-upgrade --yes
    apt-get install  --yes --quiet --no-install-recommends git libicu-dev
    git config --global --add safe.directory /app
    docker-php-ext-install -j$(nproc) intl
EOF
COPY --link --from=composer/composer:latest-bin /composer /usr/local/bin/composer
