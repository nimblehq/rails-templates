describe 'Heroku with Terraform addon - template' do
  it 'creates the heroku.yml file' do
    expect(file('heroku.yml')).to exist
  end

  it 'creates the main.tf file' do
    expect(file('deploy/main.tf')).to exist
  end

  it 'creates the config.tf file' do
    expect(file('deploy/config.tf')).to exist
  end

  it 'creates the formation.tf file' do
    expect(file('deploy/formation.tf')).to exist
  end

  it 'creates the outputs.tf file' do
    expect(file('deploy/outputs.tf')).to exist
  end

  it 'creates the terraform.tfvars file' do
    expect(file('deploy/terraform.tfvars')).to exist
  end

  it 'creates the variables.tf file' do
    expect(file('deploy/variables.tf')).to exist
  end
end
