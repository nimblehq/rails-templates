[![Build Status](CI_BADGE_URL goes here)](REPO_URL goes here)

## Introduction

App introduction goes here ...

## Project Setup

### Docker

* Install [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

* Setup and boot the Docker containers:

```
./bin/envsetup
```

* Install [Yarn](https://yarnpkg.com/lang/en/docs/install/#mac-tab)

```
brew install yarn
```

### Development

* Setup the databases:

    * Postgres:
    
    ```
    rake db:setup
    ```

* Run the Rails app

```
foreman start -f Procfile.dev
```

### Automated Code Review Setup

* Replace [EMAIL] and [PASSWORD] in `pronto.yml` with valid user credentials.

* In the CI build script, add the following command:
        
  ```
    if ([ $BRANCH_NAME != 'master' ] && [ $BRANCH_NAME != 'development' ]); then (echo "Running pronto"; bundle exec pronto run -f bitbucket_pr -c origin/development); else (echo "Escaping pronto"); fi
  ```