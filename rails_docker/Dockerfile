FROM ruby:2.6.5-slim

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

ENV APP_HOME=/#{app_name} \
    PORT=80

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
    BUNDLE_JOBS=4 \
    BUNDLE_PATH="/bundle"

ENV NODE_VERSION="8"

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US:en"

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends apt-transport-https curl gnupg

# Add Yarn repository
ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg
RUN apt-key add /tmp/yarn-pubkey.gpg && rm /tmp/yarn-pubkey.gpg && \
    echo "deb http://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list

# Add the PPA (personal package archive) maintained by NodeSource
# This will have more up-to-date versions of Node.js than the official Debian repositories
RUN curl -sL https://deb.nodesource.com/setup_"$NODE_VERSION".x | bash -

# Install general required core packages, Node JS related packages and Chrome (testing)
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential libpq-dev nodejs yarn && \
    apt-get install -y --no-install-recommends rsync locales chrpath pkg-config libfreetype6 libfontconfig1 git cmake wget unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up the Chrome PPA and install Chrome Headless
RUN if [ "$BUILD_ENV" = "test" ]; then \
      wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
      echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list.d/google-chrome.list && \
      apt-get update -qq && \
      apt-get install -y --no-install-recommends google-chrome-stable && \
      rm /etc/apt/sources.list.d/google-chrome.list && \
      apt-get clean && \
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
COPY Gemfile* ./

# Skip installing gem documentation
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
RUN bundle exec rails i18n:js:export
RUN bundle exec rails assets:precompile

EXPOSE $PORT

CMD ./bin/start.sh
