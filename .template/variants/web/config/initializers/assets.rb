append_to_file 'config/initializers/assets.rb' do
  <<~EOT

    # Add Yarn node_modules folder to the asset load path.
    Rails.application.config.assets.paths << Rails.root.join('node_modules')
  EOT
end
