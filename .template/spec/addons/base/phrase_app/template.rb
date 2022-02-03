describe 'PhraseApp addon - template' do
  it 'creates .phraseapp.yml file' do
    expect(file('.phraseapp.yml')).to exist
  end

  it 'adds PhraseApp to codebase_spec' do
    expect(file('spec/codebase/codebase_spec.rb')).to contain("it 'does not offend PhraseApp Pull configuration' do")
  end
end
