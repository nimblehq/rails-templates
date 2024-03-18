# frozen_string_literal: true

require File.expand_path('../../../lib/thor_utils', __dir__)

use_source_path __dir__

def copy_template_files
  ThorUtils.ignore_tt do
    directory 'lib/templates', renderTemplates: false
  end
end

copy_template_files
