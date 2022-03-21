# frozen_string_literal: true

describe 'Bootstrap addon - template' do
  it 'creates app/assets/stylesheets/vendor/index.scss' do
    expect(file('app/assets/stylesheets/vendor/index.scss')).to exist
  end

  it 'creates app/assets/stylesheets/vendor/_bootstrap.scss' do
    expect(file('app/assets/stylesheets/vendor/_bootstrap.scss')).to exist
  end

  it 'creates javascript/vendor/index.js' do
    expect(file('app/javascript/vendor/index.js')).to exist
  end

  it 'creates app/javascript/vendor/bootstrap/index.js' do
    expect(file('app/javascript/vendor/bootstrap/index.js')).to exist
  end
end
