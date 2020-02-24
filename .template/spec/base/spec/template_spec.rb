describe '/spec template' do
  it 'creates the base spec directory' do
    expect(file('spec/codebase')).to be_directory
    expect(file('spec/controllers')).to be_directory
    expect(file('spec/fabricators')).to be_directory
    expect(file('spec/models')).to be_directory
    expect(file('spec/requests')).to be_directory
    expect(file('spec/support')).to be_directory
  end

  it 'creates spec support files' do
    expect(file('spec/support/bullet.rb')).to exist
    expect(file('spec/support/database_cleaner.rb')).to exist
    expect(file('spec/support/devise.rb')).to exist
    expect(file('spec/support/request_helpers.rb')).to exist
    expect(file('spec/support/retry.rb')).to exist
    expect(file('spec/support/shoulda_matchers.rb')).to exist
    expect(file('spec/support/sidekiq.rb')).to exist
    expect(file('spec/support/simplecov.rb')).to exist
    expect(file('spec/support/vcr.rb')).to exist
  end

  it 'creates spec api schemas directory' do
    expect(file('spec/support/api/schemas')).to be_directory
  end

  it 'creates codebase spec' do
    expect(file('spec/codebase/codebase_spec.rb')).to exist
  end
end
