# frozen_string_literal: true

describe 'Hotwire Addon - eslintrc' do
  it 'adds the env "jest" to the eslint configuration' do
    eslintrc = JSON.parse(file('.eslintrc').content)

    expect(eslintrc['env']).to include('jest')
  end
end
