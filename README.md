# 🌐 2-Tier Architecture Deployment using Terraform (AWS)

This project deploys a **2-Tier Architecture** on AWS using **Terraform**, including:

- **VPC**
- **Public & Private Subnets**
- **Internet Gateway**
- **Route Table**
- **Security Group**
- **Public EC2 (Web Server)**
- **Private EC2 (Database Server)**  
- **S3 Backend for Remote State**

---

## 🏗️ Project Architecture

![](/img/2-tire-digram.png)

This project uses:

- **Public Subnet → Web Server**
- **Private Subnet → Database Server**
- **IGW → Internet Access**
- **Routing → Only public subnet gets 0.0.0.0/0**
- **SG → SSH, HTTP, MySQL Allowed**

📌 *Add your architecture diagram here:*

```
![Architecture](screenshots/architecture.png)
```

---

## 📁 Project Structure

```
.
├── main.tf
├── variables.tf
├── output.tf
└── README.md
```

---

## ⚙️ Terraform Backend Configuration (S3)

```hcl
terraform {
  backend "s3" {
    bucket = "aclewala"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```

---

## 🧩 Variables Used

```hcl
variable "region"        { default = "ap-south-1" }
variable "az1"           { default = "ap-south-1b" }
variable "az2"           { default = "ap-south-1c" }
variable "vpc_cidr"      { default = "10.0.0.0/16" }
variable "private_cidr"  { default = "10.0.1.0/24" }
variable "public_cidr"   { default = "10.0.2.0/24" }
variable "project_name"  { default = "FCT" }
variable "igw_cidr"      { default = "0.0.0.0/0" }
variable "ami"           { default = "ami-03695d52f0d883f65" }
variable "instance_type" { default = "t3.micro" }
variable "key"           { default = "terraform" }
```

---

## 🛠️ Resources Created

### ✔️ VPC  
### ✔️ Public & Private Subnets  
### ✔️ Internet Gateway  
### ✔️ Route Table & Route  
### ✔️ Security Group  
### ✔️ EC2 (Web - Public Subnet)  
### ✔️ EC2 (DB - Private Subnet)

---

## 🚀 Deployment Steps

![](/img/Screenshot%20(85).png)

### 1️⃣ Initialize Terraform

```
terraform init
```

---

### 2️⃣ Validate Configuration

```
terraform validate
```

---

### 3️⃣ View Plan

```
terraform plan
```

---

### 4️⃣ Apply Configuration

```
terraform apply -auto-approve
```

---

## 📤 Outputs

```hcl
output "public_ip" {
  value = aws_instance.public-server.public_ip
}

output "private_ip" {
  value = aws_instance.private-server.private_ip
}
```

---

## 📸 Screenshots (Add your images)


![](/img/Screenshot%20(89).png)

![](/img/Screenshot%20(88).png)

![](/img/Screenshot%20(90).png)

![](/img/Screenshot%20(91).png)

![](/img/Screenshot%20(93).png)

![](/img/Screenshot%20(95).png)

![](/img/Screenshot%20(96).png)

---

## 🧹 Destroy Infrastructure

When finished, destroy everything:

```
terraform destroy -auto-approve
```

---

## ✨ Summary

This project demonstrates:

- Infrastructure as Code (IaC)
- Secure 2-Tier AWS Architecture
- Reusable & Modular Terraform code
- Remote state backend using S3

Perfect for **DevOps Projects**, **Cloud Portfolio**, and **Resume Portfolio Projects**.

---

## 👨‍💻 Author

**Vaibhav Navnath Bhuse**

---

