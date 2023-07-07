<p align="center">
  <img alt="Nimble logo" src="https://assets.nimblehq.co/logo/light/logo-light-text-320.png" />
</p>

<p align="center">
  <strong>Rails Templates</strong>
</p>


---

Our templates offer a rich boilerplate to jump start Rails-based application development and are based on our experience
with building complex applications over the years.

## Get Started

### Requirements

- Install ruby and set your local ruby version to `3.2.2`
- Install rails `7.0.6`
- Install node `16.20.1` (For creating web application)

> 📝 If running on Apple M1, to build docker image, please make sure to set platform to AMD64 by `export DOCKER_DEFAULT_PLATFORM=linux/amd64`

### Use the template

In order to use the template, initialize a new app with the following parameters:

```sh
rails new <app_name> -m https://raw.githubusercontent.com/nimblehq/rails-templates/main/template.rb
```

Supported template options:
- `--api` - create an api-only application

To apply the template on an existing application, run following rails command:

```sh
rails app:template LOCATION=https://raw.githubusercontent.com/nimblehq/rails-templates/main/template.rb

# To apply on an api application
rails app:template LOCATION=https://raw.githubusercontent.com/nimblehq/rails-templates/main/template.rb API=true

# To apply a specific addon
rails app:template LOCATION=https://raw.githubusercontent.com/nimblehq/rails-templates/main/template.rb ADDON=<addon name>
```

Available Addons:
- `docker`
- `nginx`
- `phrase`
- `semaphore`
- `bootstrap`
- `slim`
- `devise`

After the template finishes generating all the files, run the following command to start the rails server.

```sh
make dev
```

Read more about Rails Application Template in the [official Rails Guides](https://guides.rubyonrails.org/rails_application_templates.html).

See the contribution guidelines in the [Wiki](../../wiki/Contribution_Guide).

## Testing the Template

To run [RuboCop](https://github.com/rubocop/rubocop) against the template:

```sh
.template/bin/rubocop
```

Any RuboCop command options can be passed:

```sh
# Run RuboCop with auto correct
.template/bin/rubocop -a
```

## License

This project is Copyright (c) 2014 and onwards. It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## About

![Nimble](https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png)

This project is maintained and funded by Nimble.

We love open source and do our part in sharing our work with the community!
See [our other projects][community] or [hire our team][hire] to help build your product.

[community]: https://github.com/nimblehq
[hire]: https://nimblehq.co/
