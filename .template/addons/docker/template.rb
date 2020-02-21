use_source_paths [__dir__]

template 'Dockerfile.tt'
template 'docker-compose.dev.yml.tt'
template 'docker-compose.test.yml.tt'
template 'docker-compose.yml.tt'
template '.env.tt'
template '.dockerignore.tt'
