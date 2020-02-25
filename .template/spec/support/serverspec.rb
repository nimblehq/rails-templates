require 'serverspec'
require 'docker-api'

RSpec.configure do |config|
  config.before(:suite) do
    # Prebuild docker image before running the test
    # Because the docker api does not support docker compose
    image = Docker::Image.get("nimblehq/#{ENV.fetch('APP_NAME')}")
    $container = image.run('bin/rails s')

    set :os, family: :debian
    set :backend, :docker
    set :docker_container, $container.id
  end

  config.after(:suite) do
    $container.stop
    $container.remove(force: true)
  end
end
