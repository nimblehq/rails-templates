FROM ruby:2.4.2-slim

# Define all the envs here
ENV APP_HOME /#{app_name}
ENV PORT 80

ENV BUNDLE_JOBS=4
ENV BUNDLE_PATH="/bundle"

ENV NODE_VERSION="8"

ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
ENV LANGUAGE="en_US:en"

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends apt-transport-https curl

# Add Yarn repository
ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg
RUN apt-key add /tmp/yarn-pubkey.gpg && rm /tmp/yarn-pubkey.gpg && \
    echo "deb http://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list

# Add the PPA (personal package archive) maintained by NodeSource
# This will have more up-to-date versions of Node.js than the official Debian repositories
RUN curl -sL https://deb.nodesource.com/setup_"$NODE_VERSION".x | bash -

# Install Node JS related packages & general required core packages
RUN apt-get install -y --no-install-recommends build-essential libpq-dev nodejs yarn && \
    apt-get install -y --no-install-recommends rsync locales chrpath pkg-config libfreetype6 libfontconfig1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i "s/^#\ \+\(en_US.UTF-8\)/\1/" /etc/locale.gen
RUN locale-gen en_US.UTF-8

RUN mkdir "$APP_HOME"
WORKDIR $APP_HOME

# Only copy the dependency definition files (Gemfile and packages) to use Docker cache for these steps
# Install Ruby dependencies
COPY Gemfile* ./
COPY engines ./engines/
RUN bundle install --jobs $BUNDLE_JOBS --path $BUNDLE_PATH

# Install JS dependencies
COPY package.json yarn.lock ./
RUN yarn install

# Copying the app files must be placed after the dependencies setup
# since the app files always change thus cannot be cached
COPY . ./

# Compile assets
RUN RAILS_ENV=$RAILS_ENV bundle exec rake assets:precompile

# Make the init file executable
RUN chmod +x ./bin/start.sh

EXPOSE $PORT

CMD ./bin/start.sh
