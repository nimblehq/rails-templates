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
    In case if we want to create a new file that Rails has not generated.

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

### Template Strings

When using template string with heredoc, use the proper name following the file type / content.

This provides the meaningful context to the content and some IDEs also support to highlight the content depending on the type.

- `DOCKERFILE`
- `ERB`
- `HTML`
- `IGNORE` - For any ignore file e.g. `.gitignore`, `.eslintignore`
- `JAVASCRIPT`
- `JSON`
- `PROCFILE`
- `RUBY`
- `SCSS`
- `SHELL`

For other files that are not fit the types above, use the extension as the name
e.g. `TOOL_VERSION` for `.tool-version` file.

For the normal string, name it after the content
e.g. `ERROR` for template error message.
