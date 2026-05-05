# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

A Rails Application Template (https://guides.rubyonrails.org/rails_application_templates.html) — not a Rails app itself. The output is consumed by `rails new <app> -m template.rb` to scaffold a Nimble-flavored Rails 7.1 / Ruby 3.3.1 project. There is no `app/`, no database, and no server to run here. The "running" version of this project is the *generated app* produced from it.

Two variants are produced from the same template:
- **Web variant** (default) — full-stack with Node 22 / Yarn assets
- **API variant** — `rails new --api`, JSON-only

Both share a common base; variant-specific code lives under `.template/variants/{api,web}/`.

## Repository layout (load-bearing pieces)

- `template.rb` — entry point invoked by `rails new -m`. Reads ENV/options, asks the user about optional addons, applies base files, default addons, optional addons, then variant. Can also be invoked with `ADDON=<name>` to apply a single addon to an existing app.
- `Gemfile.tt`, `Makefile.tt`, `README.md.tt`, `.ruby-version.tt`, etc. — root-level Thor templates copied into the generated app. The `.tt` extension matters: Thor processes ERB inside them.
- `bin/template.rb`, `config/template.rb`, `spec/template.rb`, `.gitignore.rb` — sub-templates `apply`-ed by the root `template.rb`. They each `use_source_path __dir__` and copy the files in their own folder into the generated app.
- `.template/` — everything that isn't part of the base scaffold:
  - `addons/{docker,heroku,devise,bootstrap,slim,nginx,phrase,openapi,github,hotwire,svgeez,crud,custom_cops}/template.rb` — each is a Thor sub-template applied conditionally. `docker` and `heroku` are default; the rest are prompted (or auto-included by `crud`).
  - `variants/{api,web}/template.rb` — branch the generated app based on `--api` flag.
  - `hooks/before_complete/{fix_rubocop,report}.rb` — run last, after all addons.
  - `lib/template.rb` + `lib/thor_utils.rb` — shared helpers (`Template::Messages`, `Template::Errors`, `ThorUtils.ignore_tt` for copying `.tt` files verbatim).
  - `spec/` — RSpec + serverspec tests that run **inside the generated Docker container** to verify the generated app is correctly structured. Specs live under `spec/{base,addons/base,addons/variants/{api,web},variants/{api,web}}/`.
  - `Gemfile` — gems for the test harness only (`rspec`, `rspec-wait`, `serverspec`, `docker-api`, `rubocop`).
  - `.rubocop.yml` — linter config for the template files themselves (looser than the rules shipped to the generated app).
- `rubocop/custom_cops/{required_inverse_of_relations,class_template}.rb` — custom cops shipped to generated apps via the `custom_cops` addon. Required by the root `.rubocop.yml` so they also lint *this* repo. The `rubocop/` folder has its own Gemfile for cop-development workflow.
- `spec/` (top-level) — copied verbatim into the generated app as its starter test suite (rails_helper, fabricators, support, etc.). Not the test suite for *this* repo.

## Architecture: how the template runs

1. `template.rb` is loaded by `rails new -m` (or `rails app:template`). When invoked via URL, `remote_repository` clones the repo into a tmpdir and uses that as `template_root`.
2. `apply_template!` orchestrates the order: base files → `bin/`, `config/`, `spec/`, `.gitignore` sub-templates → `after_bundle` block (runs `spring stop`, applies `spec/template.rb`) → default addons (docker, heroku) → prompt for optional addons → apply optional addons → variant template → custom cops → before-complete hooks.
3. `use_source_path` prepends a directory to Thor's `@source_paths` so `template`/`copy_file`/`directory` calls resolve relative to the right folder. Sub-templates always start with `use_source_path __dir__`.
4. The CRUD addon is special: it implies Devise + Bootstrap + Slim, and is applied near the end (after variants).
5. `ENV['ADDON']=<name>` short-circuits the full flow and applies just one addon — used by `rails app:template ADDON=...` for retrofitting existing apps.

When adding a new addon: create `.template/addons/<name>/template.rb`, add the prompt in `ask_for_optional_addons`, dispatch in `apply_optional_addons`, and add specs under `.template/spec/addons/base/<name>/` (or under variants if it differs per variant).

## Common commands

Generate an app from this checkout (for manual testing):
```sh
make create_web APP_NAME=my-app    # answers Y to all prompts
make create_api APP_NAME=my-app    # api variant
make cleanup APP_NAME=my-app       # rm -rf the generated app
```
`OPTIONS=` can be passed through, e.g. `make create_web APP_NAME=foo OPTIONS="--skip-git"`.

Run the template's test suite (must be done **after** generating an app — the specs run against the generated container):
```sh
make build APP_NAME=my-app                   # builds docker-compose.test.yml images
make test_template APP_NAME=my-app VARIANT=web   # or VARIANT=api
make test_variant_app APP_NAME=my-app        # runs the generated app's own rspec inside docker
```
The `test_template` target spins up `db` + `redis`, starts the generated app's container, and runs serverspec tests against it from `.template/`. It auto-selects spec patterns based on `VARIANT`.

Lint the template Ruby itself:
```sh
bundle install                                          # in repo root
bundle exec rubocop --config .template/.rubocop.yml --parallel
```
This is what CI (`.github/workflows/test_template.yml`) runs. Note the **two** rubocop configs:
- `.rubocop.yml` (root) — linter config that gets copied to the generated app
- `.template/.rubocop.yml` — linter config for the template's own Ruby code (`template.rb`, addon `template.rb` files, hooks)

Custom cops have their own setup:
```sh
cd rubocop && bundle install && bundle exec rspec
```

Run a single template spec (after building the container):
```sh
cd .template && bundle exec rspec spec/base/template_spec.rb
cd .template && bundle exec rspec spec/addons/base/devise/template_spec.rb -e 'when something'
```

## Conventions worth knowing

- **`.tt` files** are Thor ERB templates; **`.rb` files inside `.template/`** named `template.rb` (or `Gemfile.rb`, `package.json.rb`, etc.) are sub-templates `apply`-ed from the parent. Don't confuse the two.
- Files that need to land in the generated app *with* a `.tt` extension preserved (e.g. `.ruby-version.tt`, `.tool-versions.tt`) are handled via `ThorUtils.ignore_tt { copy_file ... }` — see `lib/thor_utils.rb`.
- Custom cop `CustomCops/ClassTemplate` enforces a class layout convention; `CustomCops/RequiredInverseOfRelations` enforces `inverse_of:` on Rails associations. Both ship to generated apps.
- Rubocop `Layout/LineLength` is 130; spec files are exempt from line-length and block-length limits.
- `RSpec/ContextWording` requires `when` or `given` prefixes (no `with`/`without`).
- The generated app uses Postgres 16.3 + Redis 7.0.9 (versions pinned in `template.rb` constants).
