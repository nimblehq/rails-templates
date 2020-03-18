describe '/test template' do
  it 'does NOT create a test directory' do
    expect(file('test')).not_to be_directory
  end
end
