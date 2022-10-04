
resource "aws_security_group" "sg_terraform" {
  name = "sg_terraform"
  description = "security_group_terraform"

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  
  ingress {
    description = "HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

    ingress {
      description = "SSH"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
    
    egress {
      description = "ALL TRAFFIC"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "SG created with Terraform"
  }
}

resource "aws_instance" "instance_terraform" {
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  security_groups = [ "sg_terraform" ]
  user_data = <<-EOF
    #! /bin/bash
    sudo apt-get update
    sudo apt-get remove docker docker-engine docker.io
    sudo apt install docker.io -y
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "you SSH key" | sudo tee /root/.ssh/authorized_keys
  EOF

  tags = {
    Name = "Instance created with Terraform"
  }
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value = aws_instance.instance_terraform.public_ip
}
