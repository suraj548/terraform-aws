variable "prefix" {
  default = "suraj"
}
//variables used to create EBS Volume
variable "ebs_zone" {
  type = string
  default = "ap-south-1a"
  description = "the availabe zone where the data will be stored"
}
variable "ebs_size" {
  type = number
  default = 1
  description = "the size of the volume created"
}
variable "ebs_name" {
  type = string
  default = "ebs"
  description = "name of the volume"
}

//variables used to create Security Groups
variable "ingress_ssh" {
  type = object({
     description     = string
    from_port        = number
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    type             = string
    protocol         = string
    cidr_blocks      = list(string)
    security_groups  = list(string)
    self             = bool
    to_port          = number
  })
  default = {
    cidr_blocks = [ "0.0.0.0/0"]
    description = "for ssh"
    from_port = 22
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 22
    type = "ssh"
  }
  description = "inbound rule for ssh connection"
}

variable "ingress_http" {
  type = object({
     description     = string
    from_port        = number
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    type             = string
    protocol         = string
    cidr_blocks      = list(string)
    security_groups  = list(string)
    self             = bool
    to_port          = number
  })
  default = {
    cidr_blocks = [ "0.0.0.0/0"]
    description = "for http"
    from_port = 80
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 80
    type = "http"
  }
  description = "inbound rule for http requests"
}

variable "ingress_https" {
  type = object({
     description     = string
    from_port        = number
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    type             = string
    protocol         = string
    cidr_blocks      = list(string)
    security_groups  = list(string)
    self             = bool
    to_port          = number
  })
  default = {
    cidr_blocks = [ "0.0.0.0/0"]
    description = "for https"
    from_port = 443
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 443
    type = "https"
  }
  description = "inbound rule for secured http requests"
}

variable "egress-outbound" {
  type = object({
     description      = string
    from_port        = number
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    protocol         = string
    cidr_blocks      = list(string)
    security_groups  = list(string)
    self             = bool
    to_port          = number
  })
  default = {
    cidr_blocks = ["0.0.0.0/0"]
    description = "out-bound-rule"
    from_port = 0
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "-1"
    security_groups = []
    self = false
    to_port = 0
  }
  description = "Outbound rule created for the instance"
}

//variables used to create pulickey and private key
variable "key-name" {
  type = string
  default = "ub-key"
  description = "name of the public key stored in remote server"
}

variable "private-key-location" {
  type = string
  default = "D:/Terraform/terraform-aws/keys/ub-key"
  description = "location where the private key is present"
}
variable "public-key-location" {
  type = string
  default = "D:/Terraform/terraform-aws/keys/ub-key.pub"
  description = "public key sent to server"
}

//variables used to create ec2 instance
variable "hexvalue-lenght" {
  default     = 3
  type        = number
  description = "This specifies the number of bytes used to create a hex value"
}

variable "ec2-ami" {
  type= string
  default = "ami-079b5e5b3971bd10d"
  description = "type of vm created"
}

variable "ec2-type" {
  type = string
  default = "t2.micro"
  description = "the hardware created for the instance"
}

variable "ec2-name" {
  type = string
  default = "https-creation"
  description = "name of the ec2 instance"
}

//variables used to create null resource
variable "file-source" {
  type = string
  default = "D:/Terraform/terraform-aws/index.html"
  description = "the source from where the content will be fetched for remote server"
}

variable "file-destination" {
  type = string
  default = "/home/ec2-user/index.html"
  description = "the place where the contents will be pasted in remote VM"
}

variable "remote-user" {
  type = string
  default = "ec2-user"
  description = "the remote user"
}

variable "connection-type" {
  type = string
  default = "ssh"
  description = "type of connection to remote"
}

variable "config-commands" {
  type = list(string)
  default = [  "sudo yum update -y",
      "sudo yum install -y httpd httpd-tools",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd" ,
      "sudo mv /home/ec2-user/index.html /var/www/html/index.html"  ]
  
  description = "these commands intall and run httpd service"
}

//variables used to mount storage on the instance
variable "mount-dev-name" {
  type = string
  default =  "/dev/sde"
  description = "mount device name"
}
