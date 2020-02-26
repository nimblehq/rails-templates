require 'serverspec'
require 'docker-api'

RSpec.configure do |config|
  config.before(:suite) do
    # Prebuild and run docker image before running the test
    # Because the docker api does not support docker compose
    container_id = `docker ps -qf "name=#{ENV.fetch('APP_NAME')}_test"`
    $container = Docker::Container.get(container_id.strip)

    set :os, family: :debian
    set :backend, :docker
    set :docker_container, $container.id
  end

  config.after(:suite) do
    $container.stop
    $container.remove(force: true)
  end
end
