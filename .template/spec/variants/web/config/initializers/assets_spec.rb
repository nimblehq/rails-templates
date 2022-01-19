describe 'Web variant - config/initializers/assets.rb' do
  subject { file('config/initializers/assets.rb') }

  it 'configures the assets to add node_modules to the pipeline' do
    expect(subject).to contain("Rails.application.config.assets.paths << Rails.root.join('node_modules')")
  end
end
