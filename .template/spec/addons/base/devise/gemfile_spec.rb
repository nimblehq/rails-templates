describe 'Devise Addon - Gemfile' do
  subject { file('Gemfile') }

  it 'adds devise gem' do
    expect(subject).to contain('devise')
  end

  it 'adds devise-i18n gem' do
    expect(subject).to contain('devise-i18n')
  end
end
