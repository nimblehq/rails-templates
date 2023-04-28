# frozen_string_literal: true

use_source_path __dir__

template 'Dockerfile.tt'
template 'docker-compose.dev.yml.tt'
template 'docker-compose.test.yml.tt'
template 'docker-compose.yml.tt'
template '.dockerignore.tt'

append_to_file '.env.example' do
  <<~ENVEXAMPLE

    # Docker
    DOCKER_REGISTRY_HOST=#{DOCKER_REGISTRY_HOST}
    DOCKER_IMAGE=#{DOCKER_IMAGE}
    BRANCH_TAG=latest
    PORT=80
  ENVEXAMPLE
end
