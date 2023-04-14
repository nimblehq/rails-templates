# frozen_string_literal: true

describe 'Phrase addon - template' do
  it 'creates .phrase.yml file' do
    expect(file('.phrase.yml')).to exist
  end

  it 'adds Phrase to codebase_spec' do
    expect(file('spec/codebase/codebase_spec.rb')).to contain("it 'does not offend Phrase Pull configuration' do")
  end
end
