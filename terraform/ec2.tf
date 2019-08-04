# ec2.tf 
# Create VPC/Subnet/Security Group/ACL

provider "aws" {
  region                 = var.region
  skip_region_validation = true
  version                = "~> 2.0"
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = var.pub_key
}

resource "aws_instance" "testserver1" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    host = coalesce(self.public_ip, self.private_ip)
    type = "ssh"
    # The default username for our AMI
    user = "ubuntu"
    # The connection will use the local SSH agent for authentication.
  }

  ami           = "ami-09eb5e8a83c7aa890"
  instance_type = "t2.micro"

  # The name of our SSH keypair we created above.
  key_name = aws_key_pair.auth.key_name

  #our Security group to allow HTTP and SSH access
  #vpc_security_group_ids = ["${aws_security_group.default.id}"]
  vpc_security_group_ids = [aws_security_group.DEV_TEST_Security_Group.id]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  #subnet_id = "${aws_subnet.default.id}"
  subnet_id = aws_subnet.DEV_TEST_Subnet.id

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World, From Eddie.... My WAN/Public IP address: " > index.html
              nohup busybox httpd -f -p 80 &
	      #sudo apt update
	     # sudo apt install git -y
	     # sudo apt install openjdk-8-jdk -y
	     # cd ~
	      #git clone https://github.com/edjwhho/0408-2019.git
	      #java -jar target/umsl-0.0.1-SNAPSHOT.jar
EOF


  tags = {
    Name = "UMSL-WebSvr-DevEC2"
  }

  provisioner "local-exec" {
    command = " curl http://myexternalip.com/raw > index.html "
  }
}

