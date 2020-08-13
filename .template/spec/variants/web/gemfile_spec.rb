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

    it 'adds danger-slim_lint gem' do
      expect(subject).to contain('danger-slim_lint').after('^group :development, :test')
    end

    it 'adds danger-eslint gem' do
      expect(subject).to contain('danger-eslint').after('^group :development, :test')
    end

    it 'adds scss_lint gem' do
      expect(subject).to contain('scss_lint').after('^group :development, :test')
    end
  end

  describe 'Test Environment' do
    it 'adds rspec-retry gem' do
      expect(subject).to contain('rspec-retry').after('^group :test')
    end
  end
end
