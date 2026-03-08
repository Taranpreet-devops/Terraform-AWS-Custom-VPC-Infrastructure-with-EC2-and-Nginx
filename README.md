<div align="center">
  <h1>🏗️ Terraform AWS Custom VPC Infrastructure with EC2 & Nginx</h1>
  <p><em>Production-ready AWS networking automation with Infrastructure as Code</em></p>
  
  <!-- Badges -->
  <p>
    <img src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform">
    <img src="https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white" alt="AWS">
    <img src="https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white" alt="Nginx">
    <img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge" alt="License">
  </p>
  
  <!-- Quick Links -->
  <p>
    <a href="#-architecture-overview">Architecture</a> •
    <a href="#-features">Features</a> •
    <a href="#-quick-start">Quick Start</a> •
    <a href="#-configuration">Configuration</a> •
    <a href="#-troubleshooting">Troubleshooting</a> •
    <a href="#-cleanup">Cleanup</a>
  </p>
</div>

---

## 📋 Overview

This Terraform project provisions a **complete AWS infrastructure** including a custom VPC, public subnet, internet gateway, route tables, security groups, and an EC2 instance running Nginx. It demonstrates Infrastructure as Code (IaC) best practices for AWS networking and automated server provisioning.

**Perfect for:**
- Learning AWS networking fundamentals
- Testing web applications in a secure environment
- Building a foundation for production deployments
- Demonstrating Terraform capabilities

## 🏗️ Architecture Overview







```mermaid
graph TB
    subgraph Internet["🌐 Internet"]
        User[("👤 User")]
    end
    
    subgraph AWS["☁️ AWS Cloud"]
        subgraph VPC["🕸️ Custom VPC (10.0.0.0/16)"]
            IGW[("🚪 Internet Gateway")]
            
            subgraph PublicSubnet["📡 Public Subnet (10.0.1.0/24)"]
                EC2["🖥️ EC2 Instance<br/>Amazon Linux 2"]
                SG["🛡️ Security Group<br/>Port 22 (SSH)<br/>Port 80 (HTTP)"]
            end
            
            RT["🗺️ Route Table<br/>0.0.0.0/0 → IGW"]
        end
    end
    
    User -->|HTTP/SSH| IGW
    IGW --> RT
    RT --> EC2
    EC2 --> SG
    
    classDef aws fill:#ff9900,stroke:#232f3e,stroke-width:2px,color:#232f3e;
    class VPC,IGW,PublicSubnet,EC2,SG,RT aws;







Data Flow
User accesses the application via internet

Internet Gateway enables public internet connectivity

Route Table directs traffic to/from the internet

Security Group controls access (SSH/HTTP only)

EC2 Instance hosts the Nginx web server

✨ Features
Core Infrastructure
✅ Custom VPC – Isolated network (10.0.0.0/16) with DNS support

✅ Public Subnet – DMZ for internet-facing resources

✅ Internet Gateway – Public internet connectivity

✅ Route Tables – Proper network routing configuration

✅ Security Groups – Least-privilege access (ports 22, 80 only)

Compute & Automation
✅ EC2 Instance – Amazon Linux 2 with public IP

✅ Automated Nginx – Installed via user_data script

✅ SSH Key Integration – Secure instance access

✅ Terraform Outputs – Instant access to resource details

Best Practices
✅ Modular Design – Easy to extend and modify

✅ Variable Configuration – Customizable deployments

✅ Infrastructure as Code – Version-controlled infrastructure

✅ Clean Destruction – No orphaned resources

📁 Repository Structure

.
├── 📄 ec2.tf                    # Main infrastructure (VPC, subnet, IGW, route tables, SG, EC2)
├── 📄 provider.tf                # AWS provider configuration
├── 📄 variables.tf               # Input variables (AMI, instance type, volume size)
├── 📄 outputs.tf                 # Terraform outputs (IPs, DNS, resource IDs)
├── 📄 terraform.tf               # Backend and version configuration
├── 📜 install-nginx.sh           # User data script for EC2 provisioning
├── 🔑 terra-ec2-key.pub          # Public SSH key for instance access
├── 🖼️ architecture-diagram.png    # Visual architecture overview
├── 🎥 deployment-demo.gif         # Deployment walkthrough
└── 📖 README.md                   # This documentation

⚙️ Prerequisites
Before you begin, ensure you have:

Required Tools
Tool	Version	Purpose
Terraform	>= 1.0	Infrastructure provisioning
AWS CLI	Latest	AWS API authentication
Git	Latest	Repository cloning
AWS Requirements
✅ Active AWS account

✅ IAM user with programmatic access

✅ Permissions for: EC2, VPC, IGW, Route Tables, Security Groups

✅ AWS credentials configured locally

Verification Checklist
Run these commands to confirm readiness:

# Check Terraform version
terraform --version

# Verify AWS credentials
aws sts get-caller-identity

# Confirm SSH key exist
s
ls -la terra-ec2-key.pub

# Test AWS permissions (optional)
aws ec2 describe-regions --max-items 1

🚀 Quick Start
Deploy your infrastructure in minutes:

1. Clone the Repository
git clone https://github.com/Taranpreet-devops/Terraform-AWS-Custom-VPC-Infrastructure-with-EC2-and-Nginx.git
cd Terraform-AWS-Custom-VPC-Infrastructure-with-EC2-and-Nginx
2. Initialize Terraform
terraform init
Downloads the AWS provider and sets up the working directory
3. Review the Deployment Plan
terraform plan
4. Deploy the Infrastructure
terraform apply -auto-approve
*Creates all AWS resources (approx. 2-3 minutes)*
5. Access Your Application
# View outputs
terraform output

# Example output:
# instance_public_ip = "54.123.45.67"
# instance_public_dns = "ec2-54-123-45-67.compute-1.amazonaws.com"
Open your browser and navigate to http://<instance_public_ip> to see the Nginx welcome page!

🧩 Configuration
Variables Reference
Variable	Description	Default	Required
aws_region	AWS deployment region	us-east-1	No
aws_instance_type	EC2 instance size	t3.micro	No
ec2_ami_id	Amazon Linux 2 AMI ID	ami-0b6c6ebed2801a5cb	No
block_store_size	Root EBS volume size (GB)	15	No
vpc_cidr_block	VPC CIDR range	10.0.0.0/16	No
subnet_cidr_block	Public subnet CIDR	10.0.1.0/24	No
Customizing Your Deployment
Create a terraform.tfvars file to override defaults:

# Example: Deploy to EU region with larger instance
aws_region        = "eu-west-1"
aws_instance_type = "t3.medium"
block_store_size  = 30

# Custom network ranges
vpc_cidr_block    = "172.16.0.0/16"
subnet_cidr_block = "172.16.1.0/24"
🛠️ User Data Script (install-nginx.sh)
The script runs automatically at instance launch:
#!/bin/bash
# Update package manager
yum update -y

# Install and configure Nginx
amazon-linux-extras install nginx1 -y
systemctl enable nginx
systemctl start nginx

# Create custom welcome page
cat > /usr/share/nginx/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Terraform AWS Demo</title>
    <style>
        body { font-family: Arial; text-align: center; margin-top: 50px; }
        h1 { color: #ff9900; }
    </style>
</head>
<body>
    <h1>🚀 Deployed with Terraform</h1>
    <p>EC2 Instance: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
    <p>Availability Zone: $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>
    <p>Deployed on: $(date)</p>
</body>
</html>
EOF

Note: The script uses Amazon Linux 2 package managers (yum, amazon-linux-extras), which matches the default AMI.

🔍 Troubleshooting
Common Issues and Solutions
Issue	Likely Cause	Solution
terraform apply fails	AWS credentials incorrect	Run aws configure again
Error creating VPC	Permission denied	Check IAM permissions
Can't SSH to EC2	Security group or key mismatch	Verify port 22 open and key pair name matches
Nginx not loading	Installation failed	SSH and run: systemctl status nginx
terraform output shows nothing	State not refreshed	Run terraform refresh first
High cost estimate	Instance left running	Always run terraform destroy after testing

SSH Access
# Ensure key has correct permissions
chmod 400 terra-ec2-key.pub

# Connect to instance
ssh -i terra-ec2-key.pub ec2-user@<public-ip>
Verify Nginx Installation
# Check service status
sudo systemctl status nginx

# Test local response
curl http://localhost

# View logs
sudo tail -f /var/log/nginx/access.log

💰 Cost Estimation
Estimated daily cost: < $0.50 (us-east-1, t3.micro)

Resource	Approximate Cost
EC2 (t3.micro)	$0.0104/hour (~$0.25/day)
EBS (15GB gp3)	$0.10/GB-month (~$0.05/day)
Data Transfer	Minimal for testing
VPC Components	No additional charge
⚠️ Warning: Always run terraform destroy when done testing to avoid unexpected charges!

🧹 Cleanup
Destroy all resources to prevent ongoing costs:

bash
terraform destroy
# Type 'yes' when prompted
What gets deleted:

✅ EC2 Instance

✅ Security Group

✅ Route Table & Association

✅ Internet Gateway

✅ Subnet

✅ VPC

🚀 Next Steps & Enhancements
Ready to take this further? Consider adding:

Remote State Storage – Use S3 backend with DynamoDB locking

HTTPS Support – Add ACM certificate and Route53

Multiple Environments – Create dev/staging/prod workspaces

Auto Scaling – Add ASG and Load Balancer

Monitoring – CloudWatch alarms and dashboards

Database Layer – Add RDS in private subnet

CI/CD Integration – Automate with GitHub Actions

🤝 Contributing
Contributions are welcome! Feel free to:

🍴 Fork the repository

🌿 Create a feature branch

🔧 Make your changes

✅ Submit a pull request

Reporting Issues: Found a bug? Open an issue with details.

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

🙏 Acknowledgments
Built with HashiCorp Terraform

AWS infrastructure powered by Amazon Web Services

Diagrams created with Mermaid

Inspired by the DevOps community's need for clear IaC examples

📬 Connect
Taranpreet Singh

GitHub: @Taranpreet-devops

LinkedIn: Taranpreet-devops

Project: Terraform AWS VPC Demo
