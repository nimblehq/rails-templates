describe 'config/initializers/backtrace_silencers.rb' do
  subject { file('config/initializers/backtrace_silencers.rb') }

  it 'enables Rails.backtrace_cleaner.remove_silencers!' do
    expect(subject).to contain('Rails.backtrace_cleaner.remove_silencers!')
    expect(subject).not_to contain('# Rails.backtrace_cleaner.remove_silencers!')
  end
  
  it 'adds engines to Rails.backtrace_cleaner.add_silencer' do
    expect(subject).to contain('/^engines/.match?(line)')
  end
end
