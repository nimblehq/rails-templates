# frozen_string_literal: true

def copy_env_example
  use_source_path __dir__

  run 'cp .env.example .env'
end

copy_env_example
