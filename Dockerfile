FROM php:8.2-fpm

ENV COMPOSER_HOME /usr/local/composer
ENV DEBIAN_FRONTEND=noninteractive
ENV WORKING_DIR=/var/www/html
ENV USERNAME=www-data
ENV HOST_UID=1000
ENV HOST_GID=1000

# Install necessary packages
RUN apt-get update && \
    apt-get install -y  \
      curl git software-properties-common zip unzip \
      zlib1g-dev libzip-dev libreadline-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libonig-dev && \
    # Additional php extensions
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd && \
    docker-php-ext-install gd pdo_mysql zip exif pgsql pdo_pgsql && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js 16.x
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn && \
    rm -rf /var/lib/apt/lists/*

# Install @flarum/cli globally
RUN yarn global add @flarum/cli

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Franzl Studio for local development
RUN composer global config --no-plugins allow-plugins.franzl/studio true && \
    composer global require franzl/studio

# Copy Flarum skeleton to $WORKING_DIR and workbench
COPY --chown=$USERNAME:$USERNAME flarum $WORKING_DIR
COPY --chown=$USERNAME:$USERNAME workbench $WORKING_DIR/../workbench
COPY --chown=$USERNAME:$USERNAME framework $WORKING_DIR/../framework

# Remove vendor if it exists
RUN if [ -d "$WORKING_DIR/vendor" ]; then rm -rf $WORKING_DIR/vendor; fi

# Permissions
RUN usermod -o -u $HOST_UID $USERNAME -d /home/$USERNAME \
    && groupmod -o -g $HOST_GID $USERNAME \
    && chown -R $USERNAME:$USERNAME $WORKING_DIR

# Copy entrypoint script
COPY --chown=$USERNAME:$USERNAME bin /usr/local/bin
RUN chmod +x -R /usr/local/bin

USER $USERNAME
WORKDIR $WORKING_DIR

ENV PATH="${COMPOSER_HOME}/vendor/bin:${PATH}"

# Expose port 9000 for PHP-FPM
EXPOSE 9000

ENTRYPOINT ["fl-startup"]

# Start PHP-FPM
CMD ["php-fpm"]
