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
    Owner = "${data.aws_caller_identity.current.arn}"
  }
}
