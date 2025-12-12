variable "region" {
  default = "ap-south-1"
}
variable "az1" {
  default = "ap-south-1b"
}
variable "az2" {
  default = "ap-south-1c"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "private_cidr" {
  default = "10.0.1.0/24"
}
variable "public_cidr" {
  default = "10.0.2.0/24"
}
variable "project_name" {
  default = "FCT"
}
variable "igw_cidr" {
  default = "0.0.0.0/0"
}
variable "ami"  {
  default = "ami-03695d52f0d883f65"
}
variable "instance_type" {
  default = "t3.micro"
}
variable "key" {
  default = "terraform"
}