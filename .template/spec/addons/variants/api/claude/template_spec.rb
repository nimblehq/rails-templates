# frozen_string_literal: true

describe 'Claude addon - API variant' do
  describe file('CLAUDE.md') do
    its(:content) { is_expected.to include('JSON-only API') }
    its(:content) { is_expected.to include('app/serializers/') }
    its(:content) { is_expected.not_to include('Node 22 / Yarn') }
  end
end
