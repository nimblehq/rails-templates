# frozen_string_literal: true

insert_into_file('.eslintrc', before: "\n  \"extends\"") do
  <<~ESLINTRC

    "env": {
      "jest": true
    },
  ESLINTRC
end
