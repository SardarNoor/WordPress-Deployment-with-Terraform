# AWS EC2 WordPress Deployment with Terraform

## Overview
This project automates the deployment of a complete **two-tier WordPress application** on AWS using **Terraform**.  
It provisions two EC2 instances:
- **WordPress Server (Public Subnet)** – runs Apache, PHP, and WordPress  
- **MySQL Server (Private Subnet)** – runs MariaDB for database storage  

Both instances are configured automatically using **user-data scripts**, eliminating all manual setup steps.  
The project demonstrates Infrastructure as Code (IaC), AWS networking, and automation practices.

---

## Architecture
- **VPC** with CIDR block `10.0.0.0/16`
- **Public Subnet (10.0.1.0/24)** → WordPress EC2  
- **Private Subnet (10.0.2.0/24)** → MySQL EC2  
- **Internet Gateway (IGW)** → Provides public internet access  
- **NAT Gateway** → Enables outbound access for private subnet  
- **Route Tables** → Public routes to IGW, private routes to NAT Gateway  
- **Security Groups**
  - `wp-sg` allows HTTP (80) and SSH (22)  
  - `db-sg` allows MySQL (3306) only from `wp-sg`  
- **EC2 Instances**
  - WordPress (Amazon Linux 2023, public subnet)  
  - MySQL (Amazon Linux 2023, private subnet)

---

## Files Description

| File | Description |
|------|--------------|
| `main.tf` | Defines provider, networking, EC2, and dependencies |
| `variables.tf` | Stores configurable parameters like AMI IDs and key pair |
| `outputs.tf` | Displays WordPress public IP and MySQL private IP |
| `userdata-wordpress.sh` | Installs Apache, PHP, and WordPress automatically |
| `userdata-mysql.sh` | Installs and configures MariaDB database automatically |

---

## Deployment Steps

### 1. Configure Environment
Install Terraform and AWS CLI, then run:
```bash
aws configure
terraform -version
aws sts get-caller-identity
Use region us-west-2.

2. Initialize Terraform
bash
Copy code
terraform init
terraform validate
3. Apply Terraform
bash
Copy code
terraform apply -auto-approve
Terraform provisions:

VPC, subnets, Internet Gateway, and NAT Gateway

Security groups

Two EC2 instances (WordPress + MySQL)

4. Retrieve Outputs
After successful provisioning:

ini
Copy code
wordpress_public_ip = <your-public-ip>
mysql_private_ip = <your-private-ip>
Open WordPress in browser:

cpp
Copy code
http://<wordpress_public_ip>
Complete the setup wizard and access the dashboard.

Verifying Database Connectivity
SSH into WordPress EC2:

bash
Copy code
ssh -i your-key.pem ec2-user@<wordpress-public-ip>
Install MySQL client:

bash
Copy code
sudo dnf install -y mariadb105
Connect to MySQL using its private IP:

bash
Copy code
mysql -h <mysql-private-ip> -u noor -p
Password: onePlus1@

Verify:

bash
Copy code
show databases;
Output includes:

nginx
Copy code
wordpress_db
Problems and Solutions
Problem	Cause	Solution
source_security_group_id not supported	Terraform AWS provider v5+ changed rule syntax	Created a separate aws_security_group_rule resource
Invalid value for vars map: DB_HOST	Wrong variable case in template	Changed ${DB_HOST} to ${db_host}
InvalidAMIID.NotFound	Wrong AMI ID for selected region	Used correct Amazon Linux 2023 AMI ami-04f9aa2b7c7091927
InvalidAccessKeyId	AWS CLI not configured	Ran aws configure with valid credentials
MariaDB not starting	Wrong package for Amazon Linux	Used dnf install mariadb105-server
Terraform provider mismatch	Lock file used AWS provider v6	Updated version to ~> 6.0 and reinitialized

Final Output
WordPress site running and accessible via public IP

MySQL database hosted securely in private subnet

Connection verified between WordPress and MySQL

Terraform managing all resources automatically

Author
Sardar Noor Ul Hassan
Cloud Intern – Cloudelligent
