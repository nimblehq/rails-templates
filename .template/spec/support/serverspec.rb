# frozen_string_literal: true

require 'serverspec'
require 'docker-api'
require 'logger'

module ServerSpecHelpers
  # Prebuild and run docker image before running the test
  # Because the docker api does not support docker compose
  def self.test_container
    logger = Logger.new($stdout)
    logger.level = Logger::WARN

    Docker::Container.all(:all => true).each do |container|
      logger.warn "Container: #{container.id} #{container.info['Names']}"
    end

    container_name = "rails-template-test-run"
    container_id = `docker ps -qf "name=#{container_name}"`
    logger.warn "Container name: #{container_name}"
    logger.warn "Container ID: #{container_id}"

    Docker::Container.get(container_id.strip)
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    container = ServerSpecHelpers.test_container

    set :os, family: :debian
    set :backend, :docker
    set :docker_container, container.id
  end

  config.after(:suite) do
    container = ServerSpecHelpers.test_container

    container.stop
    container.remove(force: true)
  end
end
