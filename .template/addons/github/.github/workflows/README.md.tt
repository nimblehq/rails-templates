# Github Actions
The following workflows are supported. Depends on what you choose when generating the project, some or all of them would be available:
- [Test](#test-workflow)
- [Test Production Build](#test-production-build-workflow)
- [Deploy to Heroku](#deploy-to-heroku-workflow)
- [Publish to Wiki](#publish-to-wiki-workflow)

Please refer to the following sections for usage instruction.

## Test workflow
Set up the following GitHub repository secrets.
- DOCKER_REGISTRY_HOST (currently support: `docker.io`, `ghcr.io`, `azurecr.io`, `gcr.io`, `registry.gitlab.com`)
- DOCKER_REGISTRY_USERNAME (Default: `${{ github.repository_owner }}`)
- DOCKER_REGISTRY_TOKEN (can be generated on the Docker registries)
- DOCKER_IMAGE (Default: `${{ github.repository }}`)

## Test production build workflow
Set up the following GitHub repository secrets.
- DOCKER_REGISTRY_HOST (currently support: `docker.io`, `ghcr.io`, `azurecr.io`, `gcr.io`, `registry.gitlab.com`)
- DOCKER_IMAGE (Default: `${{ github.repository }}`)

## Deploy to Heroku workflow

### Requirements
- A Heroku API key. It can be generated under your [Account Settings](https://dashboard.heroku.com/account#api-key)
- 2 pre-generated [Heroku apps](https://devcenter.heroku.com/articles/creating-apps):
  - {your-project-name}
  - {your-project-name}-staging

### How to use
- Set up the following GitHub repository secrets.
  - DOCKER_REGISTRY_HOST (currently support: `docker.io`, `ghcr.io`, `azurecr.io`, `gcr.io`, `registry.gitlab.com`)
  - DOCKER_REGISTRY_TOKEN (can be generated on the Docker registries)
  - DOCKER_REGISTRY_USERNAME (Default: `${{ github.repository_owner }}`)
  - DOCKER_IMAGE (Default: `${{ github.repository }}`)
  - HEROKU_API_KEY

- If needed, update the `.github\workflow\deploy_heroku.yml` file to matches your Heroku apps names:

  ```yml
  [...]
  - name: Set env HEROKU_APP
    run: |
      if [[ $BRANCH_TAG = "latest" ]]
      then
        echo "HEROKU_APP=HERE" >> $GITHUB_ENV
      else
        echo "HEROKU_APP=HERE-staging" >> $GITHUB_ENV
      fi
  [...]

> This step might simply be changing '_' to '-' in the app name

- Now you still need to attach a database to **each** app.
  - From [Heroku Dashboard](https://dashboard.heroku.com/apps), open the app
  - Go to the 'Resources' tab
  - In the 'Add-ons' section, search for 'Postgres' and select 'Heroku Postgres'
  - You can select a free plan to start (Hobby Dev - Free) and 'Submit Order Form'

> Note that in 'Settings > Config vars', your now have the `DATABASE_URL` variable (which is used by your Web Container)

Once all setup, give it a try by running manually the GitHub Action 'Deploy Heroku'!

> **Troubleshooting:**
> You can check at Heroku's logs from your application dashboard, in 'More > View logs'

## Publish to Wiki workflow
- Setup the Github Wiki by following this [official guide](https://docs.github.com/en/communities/documenting-your-project-with-wikis/adding-or-editing-wiki-pages#adding-wiki-pages)
- Create [Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) with `repo` scope enabled - a bot account is recommended to generate that token
- Set up the following GitHub repository secrets
  - GH_EMAIL (an email to identify the bot that publish the wiki content in the git history)
  - GH_TOKEN (the above generated token)
- Create a `.github/wiki` directory to store the documents to be published to Wiki.
