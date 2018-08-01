FROM ruby:2.4.2-slim

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

ENV CHROMEDRIVER_VERSION="2.35" \
    CHROMEDRIVER_DIR=/chromedriver

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US:en"

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends apt-transport-https curl

# Add Yarn repository
ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg
RUN apt-key add /tmp/yarn-pubkey.gpg && rm /tmp/yarn-pubkey.gpg && \
    echo "deb http://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list

# Add the PPA (personal package archive) maintained by NodeSource
# This will have more up-to-date versions of Node.js than the official Debian repositories
RUN curl -sL https://deb.nodesource.com/setup_"$NODE_VERSION".x | bash -

# Set up the Chrome PPA to install Chrome Headless
ADD https://dl-ssl.google.com/linux/linux_signing_key.pub /tmp/google-pubkey.gpg
RUN apt-key add /tmp/google-pubkey.gpg && rm /tmp/google-pubkey.gpg  && \
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list.d/google.list

# Install general required core packages, Node JS related packages and Chrome (testing)
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential libpq-dev nodejs yarn google-chrome-stable && \
    apt-get install -y --no-install-recommends rsync locales chrpath pkg-config libfreetype6 libfontconfig1 git cmake wget unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install Chromedriver
RUN mkdir "$CHROMEDRIVER_DIR" && \
    wget -q --continue -P $CHROMEDRIVER_DIR "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip" && \
    unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR

ENV PATH $CHROMEDRIVER_DIR:$PATH

RUN sed -i "s/^#\ \+\(en_US.UTF-8\)/\1/" /etc/locale.gen
RUN locale-gen en_US.UTF-8

RUN mkdir "$APP_HOME"
# Replace by the following if the application uses Rails engines
# RUN mkdir "$APP_HOME" "$APP_HOME/engines"
WORKDIR $APP_HOME

# Only copy the dependency definition files (Gemfile and packages) to use Docker cache for these steps
# Install Ruby dependencies
COPY Gemfile* ./
# Copy each engine lib/, Gemfile and .gemspec files
# Example:
# COPY engines/app_auth/lib/ ./engines/app_auth/lib/
# COPY engines/app_auth/Gemfile engines/app_auth/app_auth.gemspec ./engines/app_auth/

RUN if [ "$BUILD_ENV" = "production" ]; then bundle install --jobs $BUNDLE_JOBS --path $BUNDLE_PATH --without test ; else bundle install --jobs $BUNDLE_JOBS --path $BUNDLE_PATH ; fi

# Install JS dependencies
COPY package.json yarn.lock ./
RUN yarn install --network-timeout 100000

# Copying the app files must be placed after the dependencies setup
# since the app files always change thus cannot be cached
COPY . ./

# Compile assets
RUN bundle exec rails assets:precompile

# Make the init file executable
RUN chmod +x ./bin/start.sh

EXPOSE $PORT

CMD ./bin/start.sh
