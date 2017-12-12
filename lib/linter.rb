def setup_linters
  FileUtils.cp_r "#{current_directory}/shared/linters/.", './', verbose: true

  gsub_file '.pronto.yml', '#{app_name}', "#{app_name}"

  puts <<-EOT
    #{'=' * 80}
    Follow following steps to setup automated code reviews:
  
    1) Replace [EMAIL] and [PASSWORD] in `pronto.yml` with valid user credentials.
    2) In the CI build script, add the following command:
        ```
          if ([ $BRANCH_NAME != 'master' ] && [ $BRANCH_NAME != 'development' ]); then (echo "Running pronto"; bundle exec pronto run -f bitbucket_pr -c origin/development); else (echo "Escaping pronto"); fi
        ```
    #{'=' * 80}
  EOT
end
