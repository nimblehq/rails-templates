describe 'Web variant - Gemfile' do
  subject { file('Gemfile') }

  it 'adds i18n-js gem' do
    expect(subject).to contain('i18n-js')
  end

  it 'adds webpacker gem' do
    expect(subject).to contain('webpacker')
  end

  it 'adds sass-rails gem' do
    expect(subject).to contain('sass-rails')
  end

  describe 'Development + Test Environment' do
    it 'adds sassc-rails gem' do
      expect(subject).to contain('sassc-rails').after('^group :development, :test')
    end

    it 'adds pronto-scss gem' do
      expect(subject).to contain('pronto-scss').after('^group :development, :test')
    end

    it 'adds pronto-eslint_npm gem' do
      expect(subject).to contain('pronto-eslint_npm').after('^group :development, :test')
    end
  end

  describe 'Test Environment' do
    it 'adds rspec-retry gem' do
      expect(subject).to contain('rspec-retry').after('^group :test')
    end
  end
end
