FROM ruby:2.4.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN URL='https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb'; FILE=$(mktemp); curl -L "$URL" -o $FILE && dpkg -i $FILE; rm $FILE
RUN URL='https://nodejs.org/dist/v6.10.3/node-v6.10.3.tar.xz'; FILE=$(mktemp); curl -L "$URL" -o $FILE && tar -C /usr/local --strip-components 1 -xJf $FILE; rm $FILE

ENV LANG C.UTF-8
ENV APP_HOME /#{app_name}
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD . $APP_HOME
