describe 'Terraform EKS addon - template' do
  describe 'Kubernetes directory' do
    it 'creates the kubernetes/config-map.yml' do
      expect(file('deploy/kubernetes/config-map.yml')).to exist
    end
  
    it 'creates the kubernetes/secret.yml' do
      expect(file('deploy/kubernetes/secret.yml')).to exist
    end

    it 'creates the kubernetes/deployment.yml' do
      expect(file('deploy/kubernetes/deployment.yml')).to exist
    end
    
    it 'creates the kubernetes/service.yml' do
      expect(file('deploy/kubernetes/service.yml')).to exist
    end

    it 'creates the kubernetes/ingress.yml' do
      expect(file('deploy/kubernetes/ingress.yml')).to exist
    end

    it 'creates the kubernetes/namespace.yml' do
      expect(file('deploy/kubernetes/namespace.yml')).to exist
    end
  end

  describe 'Terraform VPC module' do
    it 'creates the main.tf' do
      expect(file('deploy/modules/vpc/main.tf')).to exist
    end

    it 'creates the variables.tf' do
      expect(file('deploy/modules/vpc/variables.tf')).to exist
    end

    it 'creates the outputs.tf' do
      expect(file('deploy/modules/vpc/outputs.tf')).to exist
    end
  end

  describe 'Terraform RDS module' do
    it 'creates the main.tf' do
      expect(file('deploy/modules/rds/main.tf')).to exist
    end

    it 'creates the variables.tf' do
      expect(file('deploy/modules/rds/variables.tf')).to exist
    end
  end

  describe 'Terraform EKS module' do
    it 'creates the main.tf' do
      expect(file('deploy/modules/eks/main.tf')).to exist
    end

    it 'creates the variables.tf' do
      expect(file('deploy/modules/eks/variables.tf')).to exist
    end

    it 'creates the outputs.tf' do
      expect(file('deploy/modules/eks/outputs.tf')).to exist
    end
  end

  describe 'Terraform ALB module' do
    it 'creates the main.tf' do
      expect(file('deploy/modules/alb/main.tf')).to exist
    end

    it 'creates the variables.tf' do
      expect(file('deploy/modules/alb/variables.tf')).to exist
    end
  end
  
  describe 'Terraform main module' do
    it 'creates the main.tf' do
      expect(file('deploy/main.tf')).to exist
    end

    it 'creates the variables.tf' do
      expect(file('deploy/variables.tf')).to exist
    end

    it 'creates the variables.tf' do
      expect(file('deploy/variables.tf')).to exist
    end

    it 'creates the terraform.tfvars' do
      expect(file('deploy/terraform.tfvars')).to exist
    end
  end

  it 'creates the iam-policy.json' do
    expect(file('deploy/iam-policy.json')).to exist
  end
end
