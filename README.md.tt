[![Build Status](CI_BADGE_URL goes here)](REPO_URL goes here)

## Introduction

> *App introduction goes here ...*

## Project Setup

### Docker

* Install [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

* Setup and boot the Docker containers:

```sh
./bin/envsetup.sh
```

### Development

* Setup the databases:

    * Postgres:

    ```sh
    rake db:setup
    ```

* Run the Rails app

```sh
foreman start -f Procfile.dev
```

## Tests

### Docker-based tests on the CI server

Add the following build settings to run the tests in the Docker environment via Docker Compose (configuration in `docker-compose.test.yml`):

* Configure the environment variable `BRANCH_TAG` to tag Docker images per branch:

```sh
export BRANCH_TAG=$SEMAPHORE_BRANCH_ID
```

Each branch needs to have its own Docker image to avoid build settings disparities and leverage Docker image caching.

> BRANCH_TAG must not contain special characters (`/`) to be valid. So using $BRANCH_NAME will not work e.g. chore/setup-docker.
An alternative is to use a unique identifier such as PR_ID or BRANCH_ID on the CI server.

* Pull the latest version the Docker image for the branch:

```sh
docker pull $DOCKER_IMAGE:$BRANCH_TAG || true
```

On each build, the CI environment does not contain yet a cached version of the image. Therefore, it is required to pull
it first to leverage the `cache_from` settings of Docker Compose which avoids rebuilding the whole Docker image on subsequent test builds.

* Build the Docker image:

```sh
docker-compose -f docker-compose.test.yml build
```

Upon the first build, the whole Docker image is built from the ground up and tagged using `$BRANCH_TAG`.

* Push the latest version of the Docker image for this branch:

```sh
docker push $DOCKER_IMAGE:$BRANCH_TAG
```

* Setup the test database:

```sh
docker-compose -f docker-compose.test.yml run test bin/bundle exec rake db:test:prepare
```

#### Semaphore CI 2.0

To setup the semaphore CI 2.0 for the project, please follow [this guideline](.semaphore/README.md)

### Test

* Run all tests:

```sh
docker-compose -f docker-compose.test.yml run test
```

* Run a specific test:

```sh
docker-compose -f docker-compose.test.yml run test bin/bundle exec spec [rspec-params]
```

### Automated Code Review Setup

* Make sure that the config file `pronto.yml` for pronto has been added as a configuration file.

* In the CI build script, add the following command:

```sh
if ([ $BRANCH_NAME != 'master' ] && [ $BRANCH_NAME != 'development' ]); then \
  (echo "Running pronto"; bundle exec pronto run -f bitbucket_pr -c origin/development);  else \ (echo "Escaping pronto"); \
fi
```
