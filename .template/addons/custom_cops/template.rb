# frozen_string_literal: true

require 'fileutils'

FileUtils.mkdir_p 'lib/custom_cops'
copy_file 'custom_cops/required_inverse_of_relations.rb', 'lib/custom_cops/required_inverse_of_relations.rb'
