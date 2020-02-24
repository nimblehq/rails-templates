# This file is ignored by .gitignore
xdescribe '.gitignore' do
  subject { file('.gitignore') }

  it 'ignores the I18n-js translation file' do
    expect(file('.gitignore')).to contain('/app/javascript/translations/translations.js')
  end

  it 'ignores the folder metadata file' do
    expect(subject).to contain('.DS_Store')
  end

  it 'ignores the Rubymine settings files' do
    expect(subject).to contain('.idea/*')
  end

  it 'ignores the coverage files' do
    expect(subject).to contain('/coverage')
  end

  it 'ignores the pronto configuration file' do
    expect(subject).to contain('.pronto.yml')
  end
end
