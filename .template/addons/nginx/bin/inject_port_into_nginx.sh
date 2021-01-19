#!/bin/bash

# On Heroku, each web process simply binds to a port, and listens for requests coming in on that port.
# The port to bind to is assigned by Heroku as the PORT environment variable randomly.
# We need to point that $PORT into Nginx HTTP listener.
# https://devcenter.heroku.com/articles/runtime-principles#web-servers
# https://dev.to/annisalli/deploying-containerized-nginx-to-heroku-how-hard-can-it-be-3g14
sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf
