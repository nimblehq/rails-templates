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

- Install ruby and set your local ruby version to `3.0.1`
- Install rails `7.0.1`

### Use the template

In order to use the template, initialize a new app with the following parameters:

```
rails new <app_name> -m https://raw.githubusercontent.com/nimblehq/rails-templates/master/template.rb
```

Supported template options:
- `--api` - create an api-only application

To apply the template on an existing application, run following rails command:

```
rails app:template LOCATION=https://raw.githubusercontent.com/nimblehq/rails-templates/master/template.rb

# To apply on an api application
rails app:template LOCATION=https://raw.githubusercontent.com/nimblehq/rails-templates/master/template.rb API=true

# To apply a specific addon
rails app:template LOCATION=https://raw.githubusercontent.com/nimblehq/rails-templates/master/template.rb ADDON=<addon name>
```

Available Addons:
- `docker`
- `nginx`
- `phrase_app`
- `semaphore`
- `bootstrap`
- `slim`
- `devise`

Read more about Rails Application Template in the [official Rails Guides](https://guides.rubyonrails.org/rails_application_templates.html).

## How to contribute

### Template structure

```
.
├── .template
│   ├── addons
│   │   └── docker
│   │       ├── ...
│   │       └── template.rb
│   └── variants
│       ├── api
│       │   ├── ...
│       │   └── template.rb
│       └── web
│           ├── ...
│           └── template.rb
├── app
├── bin
├── config
├── spec
├── ...
├── README.md
├── README.md.tt
└── template.rb
```

We keep the Rails-app-like structure. On the root, there are base project file templates.
Other files including the template options are in `.template` folder.

There are 2 kinds of the template options:

1. **Variants** - For the app main options, which are `web` and `api`.

2. **Addons** - For other extra options that we can add to the project like `docker` or `bootstrap`,
use the prompt `ask` to generate a question before generating the project.

### Template files

There are 2 template file types:

1. **`.tt` files**

    This file is used for templating the whole new file.
    In case if we want to create a new file that Rails does not generated.

2. **`.rb` files**

    This is used for modifying the files that Rails has generated.
    The file name should be the same as on the generated app.
    If it is not a ruby file, append the `.rb` as an extension e.g. `Gemfile.rb`

### Template specs

We are using [Serverspec](https://serverspec.org/) to test the template.
For any changes made, you **must** add a spec for it.

Test files are located under `.template/spec` folder

```
.
├── ...
├── .template
│   ├── ...
│   ├── spec
│   │   └── addons
│   │   │   └── base
│   │   │   │   └── docker
│   │   │   │   │   ├── ...
│   │   │   │   │   └── template_spec.rb
│   │   │   │   └── semaphore
│   │   │   │   │   ├── ...
│   │   │   │   │   └── template_spec.rb
│   │   │   └── variants
│   │   │   │   └── web
│   │   │   │   │   └── boostrap
│   │   │   │   │       ├── ...
│   │   │   │   │       └── template_spec.rb
│   │   │   │   └── api
│   │   │   │   │   └── addon
│   │   │   │   │       ├── ...
│   │   │   │   │       └── template_spec.rb
│   │   └── base
│   │   │   ├── ...
│   │   │   └── template_spec.rb
│   │   └── variants
│   │   │   └── web
│   │   │   │   ├── ...
│   │   │   │   └── template_spec.rb
│   │   │   └── api
│   │   │   │   ├── ...
│   │   │   │   └── template_spec.rb
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
