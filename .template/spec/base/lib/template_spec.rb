describe '/lib template' do
  it 'creates the directory from the app directory name' do
    expect(file("lib/#{template_application.directory_name}")).to be_directory
  end

  it 'creates the env fetcher classes' do
    expect(file("lib/#{template_application.directory_name}/env.rb")).to be_file
    expect(file("lib/#{template_application.directory_name}/fetcher.rb")).to be_file
    expect(file("lib/#{template_application.directory_name}/fetcher/base.rb")).to be_file
    expect(file("lib/#{template_application.directory_name}/fetcher/credentials.rb")).to be_file
    expect(file("lib/#{template_application.directory_name}/fetcher/docker_build.rb")).to be_file
    expect(file("lib/#{template_application.directory_name}/fetcher/environment.rb")).to be_file
    expect(file("lib/#{template_application.directory_name}/type_caster.rb")).to be_file
  end
end
