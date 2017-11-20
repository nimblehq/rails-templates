FROM ruby:2.4.2

# Define all the envs here
ENV NODE_VERSION="6"

ENV APP_HOME /#{app_name}

# ENVs to cache the gems
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile
ENV BUNDLE_JOBS=2
ENV BUNDLE_PATH="/bundle"

ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
ENV LANGUAGE="en_US:en"

# Add the PPA (personal package archive) maintained by NodeSource
# This will have more up-to-date versions of Node.js than the official Debian repositories
RUN URL=https://deb.nodesource.com/setup_"$NODE_VERSION".x; FILE=$(mktemp); curl -L "$URL" -o "$FILE" && bash "$FILE"; rm "$FILE"

# Add Yarn repository
RUN apt-get install apt-transport-https -y
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo deb https://dl.yarnpkg.com/debian/ stable main | tee /etc/apt/sources.list.d/yarn.list

# Install node
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential libpq-dev nodejs yarn && \
    apt-get install -y --no-install-recommends rsync locales build-essential chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i "s/^#\ \+\(en_US.UTF-8\)/\1/" /etc/locale.gen
RUN locale-gen en_US.UTF-8

RUN mkdir "$APP_HOME"
WORKDIR $APP_HOME

COPY Gemfile* "$APP_HOME"/

RUN bundle install

COPY . $APP_HOME
