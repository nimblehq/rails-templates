# frozen_string_literal: true

def copy_template_files
  ignore_tt do
    directory 'lib/templates', renderTemplates: false
  end
end

def ignore_tt
  # NOTE: change template extension so it would skip
  #       `when /#{TEMPLATE_EXTNAME}$/` condition and
  #        fallback to default `copy_file`
  Thor::TEMPLATE_EXTNAME.concat "_no_match" # => .tt_no_match
  yield
ensure
  # NOTE: make sure to undo our dirty work after the block
  Thor::TEMPLATE_EXTNAME.chomp! "_no_match" # => .tt
end

def directory_with_tt(...)
  ignore_tt do
    directory(...)
  end
end

copy_template_files
