# frozen_string_literal: true

describe 'Web variant - Gemfile' do
  subject { file('Gemfile') }

  it 'adds i18n-js gem' do
    expect(subject).to contain('i18n-js')
  end

  it 'adds sprockets-rails gem' do
    expect(subject).to contain('sprockets-rails')
  end

  it 'adds cssbundling-rails gem' do
    expect(subject).to contain('cssbundling-rails')
  end

  it 'adds jsbundling-rails gem' do
    expect(subject).to contain('jsbundling-rails')
  end

  describe 'Development + Test Environment' do
    it 'adds danger-eslint gem' do
      expect(subject).to contain('danger-eslint').after('^group :development, :test')
    end
  end

  describe 'Test Environment' do
    it 'adds capybara gem' do
      expect(subject).to contain('capybara').after('^group :test')
    end

    it 'adds selenium-webdriver gem' do
      expect(subject).to contain('selenium-webdriver').after('^group :test')
    end

    it 'adds webdrivers gem' do
      expect(subject).to contain('webdrivers').after('^group :test')
    end
  end
end
