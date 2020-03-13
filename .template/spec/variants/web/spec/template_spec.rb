describe 'Web variant - /spec template' do
  it 'creates spec support files' do
    expect(file('spec/support/assets.rb')).to exist
    expect(file('spec/support/capybara.rb')).to exist
    expect(file('spec/support/disable_animation.rb')).to exist
    expect(file('spec/support/system.rb')).to exist
    expect(file('spec/support/webdrivers.rb')).to exist
    expect(file('spec/support/webpacker.rb')).to exist
  end

  it 'creates system spec directory' do
    expect(file('spec/system')).to be_directory
  end
end
