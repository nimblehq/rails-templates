append_to_file '.tool-versions' do
  <<~TOOL_VERSION
    nodejs #{NODE_VERSION}
  TOOL_VERSION
end
