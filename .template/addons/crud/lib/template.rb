# frozen_string_literal: true

def copy_template_files
  copy_non_tt_files
  copy_tt_files
end

def copy_non_tt_files
  # The reason we are excluding .tt files is because 
  # this directory method will actually apply the template and remove the .tt extension in the destination
  directory 'lib/templates', exclude_pattern: /.*\.tt$/
end

def copy_tt_files
  src_path = File.join(__dir__, 'templates')
  dst_path = 'lib/templates'

  Dir.glob("#{src_path}/**/*.tt").sort.each do |file_source|
    relative_path = file_source.gsub("#{src_path}/", "")

    copy_file(file_source, File.join(dst_path, relative_path))
  end
end

copy_template_files
