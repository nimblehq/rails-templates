# frozen_string_literal: true

use_source_path __dir__

template 'Dockerfile.tt'
template 'docker-compose.dev.yml.tt'
template 'docker-compose.test.yml.tt'
template 'docker-compose.yml.tt'
template '.dockerignore.tt'

append_to_file '.env' do
  <<~ENVEXAMPLE

    # Docker
    APP_NAME=#{APP_NAME}
    DOCKER_REGISTRY_HOST=#{DOCKER_REGISTRY_HOST}
    DOCKER_IMAGE=#{DOCKER_IMAGE}
    BRANCH_TAG=latest
    PORT=80
  ENVEXAMPLE
end
