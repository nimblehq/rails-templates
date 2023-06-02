# frozen_string_literal: true

require 'serverspec'
require 'docker-api'

module ServerSpecHelpers
  # Prebuild and run docker image before running the test
  # Because the docker api does not support docker compose
  def self.test_container
    puts 'HERERERERERE'
    puts 'HERERERERERE'
    puts ENV.fetch('APP_NAME')
    puts `docker ps`
    container_id = `docker ps -qf "name=#{ENV.fetch('APP_NAME')}_test"`
    puts 'Container ID:'
    puts container_id

    Docker::Container.get(container_id.strip)
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    puts 'BEFORE SUITE'
    container = ServerSpecHelpers.test_container

    set :os, family: :debian
    set :backend, :docker
    set :docker_container, container.id
  end

  config.after(:suite) do
    puts 'AFTER SUITE'
    container = ServerSpecHelpers.test_container

    container.stop
    container.remove(force: true)
  end
end
