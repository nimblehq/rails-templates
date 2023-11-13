# frozen_string_literal: true

use_source_path __dir__

remove_file 'Dockerfile'
remove_file '.dockerignore'

template 'Dockerfile.tt'
template 'docker-compose.dev.yml.tt'
template 'docker-compose.test.yml.tt'
template 'docker-compose.yml.tt'
template '.env.tt'
template '.dockerignore.tt'
