// Create First server
resource "aws_instance" "first_server" {
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  security_groups = [ "elb-sg" ]
  user_data = <<-EOF
    #! /bin/bash
    sudo apt update
    sudo apt install apache2 -y
    sudo echo "FIRST SERVER" > /var/www/html/index.html
  EOF

  tags = {
    Name = "First WEB server"
    source = "Terraform"
  }
}

// Create Second server
resource "aws_instance" "second_server" {
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  security_groups = [ "elb-sg" ]
  user_data = <<-EOF
    #! /bin/bash
    sudo apt update
    sudo apt install apache2 -y
    sudo echo "SECOND SERVER" > /var/www/html/index.html
  EOF

  tags = {
    Name = "Second WEB server"
    source = "Terraform"
  }
}