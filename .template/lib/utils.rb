# frozen_string_literal: true

require 'tmpdir'

module Template
  module Utils
    class << self
      def remote_repo_dir
        tempdir = clone_repo
        at_exit { FileUtils.remove_entry(tempdir) }

        if (branch = __FILE__[%r{rails-templates/(.+)/template.rb}, 1])
          Dir.chdir(tempdir) { git checkout: branch }
        end

        tempdir
      end
    end

    private

    def clone_repo
      tempdir = Dir.mktmpdir('rails-templates')

      git clone: [
        '--quiet',
        'https://github.com/nimblehq/rails-templates.git',
        tempdir
      ].map(&:shellescape).join(' ')

      tempdir
    end
  end
end
