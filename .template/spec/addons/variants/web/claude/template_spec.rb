# frozen_string_literal: true

describe 'Claude addon - Web variant' do
  describe file('CLAUDE.md') do
    its(:content) { is_expected.to include('Node 24.14.1 / Yarn') }
    its(:content) { is_expected.to include('app/javascript/') }
    its(:content) { is_expected.not_to include('JSON-only API') }
  end
end
