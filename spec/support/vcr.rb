# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr'
  c.allow_http_connections_when_no_cassette = false
  c.hook_into :webmock
  c.ignore_localhost = true
  c.ignore_request do |request|
    URI(request.uri).port == 9200
  end
  c.default_cassette_options = { record: :none, match_requests_on: [:path] }
end

RSpec.configure do |config|
  # You can pass a hash to the `vcr` tag to specifcy additional options:
  #   vcr: { group: 'places/google/details', cassettes: %w(kfc red_planet)}
  #   vcr: { group: 'places/google/details', cassette: 'kfc'}
  #   vcr: { cassette: 'places/google/details', options: { decode_compressed_response: true } }
  # Any combination of the above
  #
  # Or you can pass the cassette name(s) directly as metadata
  #   vcr: 'places/google/details/red_planet'
  #   vcr: %w('oauth/google places/google/details/kfc')

  config.around(:each) do |example|
    vcr = example.metadata[:vcr]

    if vcr.nil?
      example.run
      next
    end

    if vcr.is_a? Hash
      configure_vcr_with_options(example, vcr)
    else
      Array(vcr).each { |cassette| VCR.use_cassette(cassette, {}, &example) }
    end
  end

  def configure_vcr_with_options(example, vcr_options)
    cassette_options = vcr_options[:options] || {}
    vcr_cassettes = vcr_options[:cassettes] || Array(vcr_options[:cassette])
    cassette_group = vcr_options[:group]
    vcr_cassettes.map! { |cassette| "#{cassette_group}/#{cassette}" } if cassette_group.present?
    vcr_cassettes.each do |cassette|
      puts cassette
      VCR.use_cassette(cassette, cassette_options, &example)
    end
  end
end
