# frozen_string_literal: true

require 'fileutils'

copy_file 'rubocop/custom_cops/required_inverse_of_relations.rb', mode: :preserve
directory 'rubocop/custom_cops/class_template', mode: :preserve
copy_file 'rubocop/custom_cops/class_template.rb', mode: :preserve
