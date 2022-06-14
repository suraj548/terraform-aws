resource "aws_key_pair" "key-pair" {
  key_name   = var.key-name
  public_key = file(var.public-key-location)
}

resource "aws_security_group" "ub-sg" {
  ingress = [var.ingress_ssh,var.ingress_http,var.ingress_https]

  egress = [var.egress-outbound]
}

resource "aws_ebs_volume" "ebsvolume" {
  availability_zone = var.ebs_zone
  size              = var.ebs_size
  encrypted         = false
  tags = {
    name = join("-",[var.prefix,var.ebs_name])
  }
}

resource "random_id" "hexvalue" {
  byte_length = var.hexvalue-lenght
}


resource "aws_instance" "create-ec2" {
  ami           = var.ec2-ami
  instance_type = var.ec2-type
  tags = {
    Name = join("",[var.ec2-name,random_id.hexvalue.hex])
  }
  vpc_security_group_ids = ["${aws_security_group.ub-sg.id}"]
  key_name               = aws_key_pair.key-pair.key_name

}

resource "aws_volume_attachment" "mount_volume" {
  device_name = var.mount-dev-name
  instance_id = aws_instance.create-ec2.id
  volume_id   = aws_ebs_volume.ebsvolume.id
  depends_on = [
    aws_instance.create-ec2,
    aws_ebs_volume.ebsvolume
  ]
}


resource "null_resource" "null" {
  connection {
    host        = aws_instance.create-ec2.public_ip
    type        = var.connection-type
    user        = var.remote-user
    private_key = file(var.private-key-location)
  }
  provisioner "file" {
    source      = var.file-source
    destination = var.file-destination
  }
  provisioner "remote-exec" {
    inline = var.config-commands
  }
  depends_on = [
    aws_instance.create-ec2,
    aws_volume_attachment.mount_volume
  ]
}


provider "http" {
  # Configuration options  
}

data "http" "hdata" {
  url = "http://${aws_instance.create-ec2.public_ip}"
  request_headers = {
    Accept = "application/json"
  }
  depends_on = [
    null_resource.null
  ]
  
}
