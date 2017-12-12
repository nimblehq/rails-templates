def setup_linters
  FileUtils.cp_r "#{current_directory}/shared/linters/.", './', verbose: true
end
