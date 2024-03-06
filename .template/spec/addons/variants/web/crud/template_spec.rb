# frozen_string_literal: true

describe 'CRUD addon - template' do
  it 'creates app/assets/stylesheets/layouts/index.scss' do
    expect(file('app/assets/stylesheets/layouts/index.scss')).to exist
  end

  it 'removes app/views/layouts/application.html.erb' do
    expect(file('app/views/layouts/application.html.erb')).not_to exist
  end

  it 'creates javascript/vendor/index.js' do
    expect(file('app/javascript/vendor/index.js')).to exist
  end

  it 'creates app/views/layouts/application.html.slim' do
    expect(file('app/views/layouts/application.html.slim')).to exist
  end

  it 'creates lib/templates/slim/scaffold/index.html.slim' do
    expect(file('lib/templates/slim/scaffold/index.html.slim')).to exist
  end
end
