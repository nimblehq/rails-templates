# frozen_string_literal: true

describe 'Hotwire Addon - template' do
  it 'creates the specs for the HelloWorld stimulus controller' do
    expect(file('spec/javascript/controllers/hello_controller_spec.js')).to exist
  end
end
