FROM ruby:2.4.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Define all the envs here
ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
ENV LANGUAGE="en_US:en"
ENV PHANTOM_JS="phantomjs-2.1.1-linux-x86_64"
ENV APP_HOME /#{app_name}
# ENVs to cache the gems
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile
ENV BUNDLE_JOBS=2
ENV BUNDLE_PATH="/bundle"

# Install phantomjs
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y rsync locales build-essential chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x && \
    curl -L -O https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 && \
    tar xvjf $PHANTOM_JS.tar.bz2 && \
    mv $PHANTOM_JS /usr/local/share && \
    ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin && \
    mkdir -p /root/.phantomjs/2.1.1/x86_64-linux/bin && \
    ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /root/.phantomjs/2.1.1/x86_64-linux/bin/phantomjs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i "s/^#\ \+\(en_US.UTF-8\)/\1/" /etc/locale.gen
RUN locale-gen en_US.UTF-8

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

RUN bundle install

ADD . $APP_HOME
