append_to_file '.tool-versions' do
  <<~EOT
    nodejs #{NODE_VERSION}
  EOT
end
