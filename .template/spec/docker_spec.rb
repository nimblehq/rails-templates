require 'serverspec'
require 'docker-api'
require 'docker-compose-api'

describe 'Dockerfile' do
  # Prebuild the image before running the test
  set :os, family: :debian
  set :backend, :docker
  set :docker_image, 'nimblehq/test_app'

  describe package('nodejs') do
    it { should be_installed }
  end

  describe package('yarn') do
    it { should be_installed }
  end

  xdescribe port(80) do
    it { should be_listening.with('tcp') }
  end

  it 'creates configuration files' do
    expect(file('config/application.yml')).to be_file
    expect(file('config/database.yml')).to be_file
    expect(file('config/sidekiq.yml')).to be_file
  end

  # it "installs required packages" do
  #   expect(package("nodejs")).to be_installed
  # end
end
