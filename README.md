# terraform-aws
This script creates a ec2 instance which will have the httpd service installed and enabled,and a index.html file is hosted on this remote.


1)You can create your own instance with above configuration ,you just need to pull the code then add a auth.tf file which contains the acess-key , secret-key and region , which will be availabe in the aws account.

2)Then just run terraform init, and then terraform apply which will create the ec2 instance ,security groups, security keys and the volumes with all the configuration in the instance created.