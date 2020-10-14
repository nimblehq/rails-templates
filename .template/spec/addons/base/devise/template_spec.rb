describe 'Devise addon - template' do
  it 'creates the Devise spec support file' do
    expect(file('spec/support/devise.rb')).to exist
  end
end
