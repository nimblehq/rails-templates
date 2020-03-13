# This template needs to be applied after bundle because it needs webpack to be installed first
apply 'config/webpack/environment.js.rb'

gsub_file 'config/webpacker.yml', %r{\ntest:\n\s*<<: \*default\n\s*(compile: true)\n} do
  <<~EOT
    test:
      <<: *default
      compile: false
  EOT
end
