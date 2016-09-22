FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential \
    apt-get install -y libpq-dev \ # for postgres
    apt-get install -y libxml2-dev libxslt1-dev \ # for nokogiri
    apt-get install -y libqt4-webkit libqt4-dev xvfb \ # for capybara-webkit
    apt-get install -y nodejs # for a JS runtime

ENV APP_HOME /#{app_name}
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

# Cache the gems
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle

RUN bundle install

ADD . $APP_HOME