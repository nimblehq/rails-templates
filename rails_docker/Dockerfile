FROM ruby:2.6.3-alpine3.9

ARG RUBY_ENV=development
ARG NODE_ENV=development
ARG BUILD_ENV=development
ARG ASSET_HOST=http://localhost

# Define all the envs here
ENV RACK_ENV=$RUBY_ENV \
    RAILS_ENV=$RUBY_ENV \
    NODE_ENV=$NODE_ENV \
    BUILD_ENV=$BUILD_ENV \
    ASSET_HOST=$ASSET_HOST

ENV APP_HOME=/usr/src/#{app_name}
ENV PORT=80

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
    BUNDLE_JOBS=4 \
    BUNDLE_PATH="/bundle"

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US:en"

# Install dependencies
RUN apk add \
      --no-cache \
      --update build-base \
        build-base \
        linux-headers \
        imagemagick \
        ruby \
        ruby-bundler \
        ruby-irb \
        libxml2-dev \
        libxslt-dev \
        libffi-dev \
        zlib-dev \
        git \
        postgresql \
        yarn \
        nodejs-current \
        tzdata \
        && rm -rf /var/cache/* \
        && mkdir /var/cache/apk \
        && rm -rf /var/lib/apt/lists/*

# Installs Chromium package from edge.
RUN if [ "$BUILD_ENV" = "test" ]; then \
    RUN echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
        && echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
        && apk add --no-cache \
        chromium@edge \
        harfbuzz@edge \
        nss@edge \
        freetype@edge \
        ttf-freefont@edge \
        && rm -rf /var/cache/* \
        && mkdir /var/cache/apk \
        && rm -rf /var/lib/apt/lists/* ; \
  fi

RUN mkdir "$APP_HOME"
# Replace by the following if the application uses Rails engines
# RUN mkdir "$APP_HOME" "$APP_HOME/engines"
WORKDIR $APP_HOME

# Only copy the dependency definition files (Gemfile and packages) to use Docker
# cache for these steps

# Install Ruby dependencies
COPY Gemfile* ./
# Copy each engine lib/, Gemfile and .gemspec files
# Example:
# COPY engines/app_auth/lib/ ./engines/app_auth/lib/
# COPY engines/app_auth/Gemfile engines/app_auth/app_auth.gemspec ./engines/app_auth/

RUN if [ "$BUILD_ENV" = "production" ]; then \
      bundle install --jobs $BUNDLE_JOBS \
                     --path $BUNDLE_PATH \
                     --without development test \
                     --deployment ; \
    else \
      bundle install --jobs $BUNDLE_JOBS \
                     --path $BUNDLE_PATH ; \
    fi

# Install JS dependencies
COPY package.json yarn.lock ./
RUN yarn install --network-timeout 100000

# Copying the app files must be placed after the dependencies setup
# since the app files always change thus cannot be cached
COPY . ./

# Compile assets
RUN bundle exec rails assets:precompile

EXPOSE $PORT

CMD ./bin/start.sh
