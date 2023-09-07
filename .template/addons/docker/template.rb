# frozen_string_literal: true

use_source_path __dir__

template 'Dockerfile.tt'
template 'Dockerfile.mock.tt'
template 'docker-compose.dev.yml.tt'
template 'docker-compose.test.yml.tt'
template 'docker-compose.yml.tt'
template '.env.tt'
template '.dockerignore.tt'
