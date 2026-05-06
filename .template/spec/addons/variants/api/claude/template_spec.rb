# frozen_string_literal: true

describe 'Claude addon - API variant' do
  describe file('CLAUDE.md') do
    its(:content) { is_expected.to include('JSON-only API') }
    its(:content) { is_expected.to include('app/serializers/') }
  end
end
