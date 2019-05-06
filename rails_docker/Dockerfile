FROM ruby:2.6.2-alpine3.9

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

ENV APP_HOME=/usr/src/#{app_name}/
ENV PORT=80

ENV BUNDLE_JOBS=4 \
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
    bash \
    make \
    cmake \
    imagemagick \
    ruby \
    ruby-bundler \
    ruby-irb \
    libxml2-dev \
    libxslt-dev \
    libffi-dev \
    postgresql-dev \
    zlib-dev \
    git \
    nodejs-current \
    nodejs-npm \
    tzdata && \
    rm -rf /var/lib/apt/lists/*

# Installs Chromium package from edge.
RUN if [ "$BUILD_ENV" = "test" ]; then \
  echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
    && echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
    && apk add --no-cache \
    chromium@edge \
    harfbuzz@edge \
    nss@edge \
    freetype@edge \
    ttf-freefont@edge && \
    rm -rf /var/lib/apt/lists/* ; \
fi

RUN mkdir "$APP_HOME"

# Replace by the following if the application uses Rails engines
# RUN mkdir "$APP_HOME" "$APP_HOME/engines"

# Copy each engine lib/, Gemfile and .gemspec files
# Example:
# COPY engines/app_auth/lib/ ./engines/app_auth/lib/
# COPY engines/app_auth/Gemfile engines/app_auth/app_auth.gemspec ./engines/app_auth/

WORKDIR $APP_HOME

# Move gemfile into place
COPY Gemfile* $APP_HOME

# skip installing gem documentation
RUN mkdir -p /usr/local/etc \
	&& { \
    echo '---'; \
    echo ':update_sources: true'; \
    echo ':benchmark: false'; \
    echo ':backtrace: true'; \
    echo ':verbose: true'; \
    echo 'gem: --no-ri --no-rdoc'; \
		echo 'install: --no-document'; \
		echo 'update: --no-document'; \
	} >> /usr/local/etc/gemrc

# Install Ruby gems
RUN if [ "$BUILD_ENV" = "production" ]; then \
  gem install bundler && \
  bundle install --jobs $BUNDLE_JOBS \
                 --path $BUNDLE_PATH \
                 --without development test \
                 --deployment ; \
else \
  gem install bundler && \
  bundle install --jobs $BUNDLE_JOBS \
                 --path $BUNDLE_PATH ; \
fi

# Install JS dependencies
COPY package.json $APP_HOME
RUN npm install

# Copying the app files must be placed after the dependencies setup
# since the app files always change thus cannot be cached
COPY . $APP_HOME

# Compile assets
RUN bundle exec rails assets:precompile

EXPOSE $PORT

CMD ./bin/start.sh
