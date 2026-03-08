# Terraform-AWS-Custom-VPC-Infrastructure-with-EC2-and-Nginx
Deploy a fully automated AWS infrastructure using Terraform: custom VPC, EC2 instance, and Nginx web server.


<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/266d80b3-6590-42d0-bcf8-7dff7b2bf798" />


🏗 Architecture Overview

Flow:
User → Internet → Internet Gateway → Route Table → Public Subnet → Security Group → EC2 → Nginx

Security: SSH (22) and HTTP (80) access only

Outputs: Public IP, Private IP, Public DNS

Design: Fully modular and scalable Terraform structure



📁 Repository Structure
.
├── ec2.tf                # VPC, Subnet, IGW, Route Table, SG, EC2
├── provider.tf           # AWS provider configuration
├── variables.tf          # Input variables (AMI, instance type, volume size)
├── install-nginx.sh      # EC2 setup script
├── outputs.tf            # Terraform outputs
├── terra-ec2-key.pub     # Public SSH key
├── README.md             # Documentation
├── a_technical_infographic_diagram_with_a_title_heade.png  # Architecture diagram
├── a_screencast_gif_showcases_deploying_aws_infrastru.png  # Demo GIF



⚡ Features

Automated AWS deployment with Terraform

Secure by default (SSH + HTTP restrictions)

Scalable and modular architecture

Quick verification via Terraform outputs

⚙️ Prerequisites

Terraform CLI v1.0+

AWS account + IAM permissions (VPC, EC2, IGW, SG)

SSH keypair (terra-ec2-key.pub)

AWS CLI configured (aws configure)

🚀 Deployment Instructions
# Clone repository
git clone https://github.com/Taranpreet-devops/Terraform-AWS-Custom-VPC-Infrastructure-with-EC2-and-Nginx.git
cd Terraform-AWS-Custom-VPC-Infrastructure-with-EC2-and-Nginx

# Initialize Terraform
terraform init

# Preview the infrastructure plan
terraform plan

# Apply the configuration
terraform apply -auto-approve


# Display outputs
terraform output
# Open the Public IP in browser to see Nginx landing page
🧩 Variables
Name	Default	Description
aws_instance_type	t3.micro	EC2 instance type
ec2_ami_id	ami-0b6c6ebed2801a5cb	AMI ID for EC2
block_store_size	15	Root volume size (GB)

Use a .tfvars file to override defaults if needed

🛠 Nginx Installation Script
#!/bin/bash
sudo apt-get update
sudo apt-get install nginx -y
sudo systemctl enable nginx
echo "<h1>Terraform AWS EC2 with Nginx</h1>" | sudo tee /var/www/html/index.html

Automatically installs and starts Nginx during EC2 provisioning

💡 Best Practices

Use Terraform modules for reusable components

Store state remotely (S3 + DynamoDB) for collaboration

Implement private subnets + NAT Gateway for production

Add Auto Scaling and Load Balancer for high availability

💰 Cleanup
terraform destroy

Confirm with yes to remove all resources and avoid AWS charges

🌟 Highlights

Infrastructure as Code – deploy complete AWS setup with one command

Secure by default – minimal access to EC2

Scalable & modular – ready for production extensions

Clear outputs – Public/Private IPs and DNS for verification

🔗 Links

https://github.com/Taranpreet-devops/Terraform-AWS-Custom-VPC-Infrastructure-with-EC2-and-Nginx/
https://linkedin.com/in/taranpreet-devops/


