# frozen_string_literal: true

describe 'Claude addon - template' do
  describe file('CLAUDE.md') do
    it { is_expected.to exist }
  end

  describe 'always-on sections' do
    let(:claude_md) { file('CLAUDE.md').content }

    it 'has the top-level heading' do
      expect(claude_md).to match(/\A# CLAUDE\.md/)
    end

    it 'has a "Working with this codebase" section' do
      expect(claude_md).to include('## Working with this codebase')
    end

    it 'has a "Common commands" section' do
      expect(claude_md).to include('## Common commands')
    end

    it 'documents the lint command' do
      expect(claude_md).to include('make codebase')
    end

    it 'documents the test invocation' do
      expect(claude_md).to include('docker compose -f docker-compose.test.yml run test')
    end

    it 'mentions the line-length convention' do
      expect(claude_md).to include('Line length is 130')
    end
  end

  describe 'conditional addon sections (test harness installs all addons)' do
    let(:claude_md) { file('CLAUDE.md').content }

    it 'documents Devise auth flow when Devise is installed' do
      expect(claude_md).to include('## Authentication (Devise)')
    end

    it 'documents OpenAPI commands when OpenAPI is installed' do
      expect(claude_md).to include('## OpenAPI')
    end

    it 'documents Nginx setup when Nginx is installed' do
      expect(claude_md).to include('## Nginx')
    end

    it 'documents the GitHub Actions workflow when the github addon is installed' do
      expect(claude_md).to include('## CI')
    end
  end
end
