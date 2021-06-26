provider "aws" {
  region  = "ap-southeast-1"
  profile  = "default"
}

###

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

output "default" {
  value = aws_default_vpc.default.id
}

resource "aws_instance" "web" {
  ami    = "ami-018c1c51c7a13e363" 
  instance_type = "t2.micro"

  tags = {
    Name = "By-Terraform"
  }
}

output "Instance_IP" {
  value = aws_instance.web.public_ip
}

###

resource "aws_ebs_volume" "example" {

  depends_on = [
    aws_instance.web,
  ]

  availability_zone = aws_instance.web.availability_zone
  size              = 5

  tags = {
    Name = "tf pd"
  }
}

###
 
resource "aws_volume_attachment" "ebs_att" {
  depends_on = [
    aws_ebs_volume.example,
  ]

  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.web.id
}

