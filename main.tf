resource "aws_iam_group" "mygroup1" {
  name = "mygroup1"
}

resource "aws_iam_group" "mygroup2" {
  name = "mygroup2"
}

resource "aws_iam_group" "mygroup3" {
  name = "mygroup3"
}

resource "aws_iam_user" "myuser1" {
  name = "myuser1"
}

resource "aws_iam_user" "myuser2" {
  name = "myuser2"
}

resource "aws_iam_user" "myuser3" {
  name = "myuser3"
}



resource "aws_iam_user_group_membership" "example_membership" {
  user   = aws_iam_user.myuser1.name
  groups = [aws_iam_group.mygroup1.name]
}

resource "aws_iam_user_group_membership" "example_membership2" {
  user   = aws_iam_user.myuser2.name
  groups = [aws_iam_group.mygroup2.name]
}

resource "aws_iam_user_group_membership" "example_membership3" {
  user   = aws_iam_user.myuser3.name
  groups = [aws_iam_group.mygroup3.name]
}



resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.myuser1.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_user_policy_attachment" "test-attach2" {
  user       = aws_iam_user.myuser2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_user_policy_attachment" "test-attach3" {
  user       = aws_iam_user.myuser3.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"


----------------------------------------------------------------------------------------------------------------------------------------------------------------------

create instance

resource "aws_instance" "web" {
  ami             = "ami-07c589821f2b353aa"
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.allow_tls.name]

  tags = {
    Name = "Web-Server1"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "my-sec1"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = "vpc-0aaf15e6174def8a4"

  tags = {
    Name = "my-security1"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]


  }


}


----------------------------------------------------------------------------------------------------------------------------------------------------------------------

* apache2 


data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "web" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.allow_tls.name]
  user_data = file("userdata.tpl")

  tags = {
    Name = "Web-Server"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "nginx-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = "vpc-0d136ccd6bf49aaba"

  tags = {
    Name = "nginx-sg"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]

  }
}


userdata.tpl

#!/bin/bash
sudo apt update -y
sudo apt-get install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
sudo echo "This is my page" > /var/www/html/index.html
sudo systemctl restart apache2




----------------------------------------------------------------------------------------------------------------------------------------------------------------------

* placement_group create

resource "aws_instance" "web" {
  ami             = "ami-07c589821f2b353aa"
  instance_type   = "c5.xlarge"
  security_groups = [aws_security_group.allow_tls.name]
  placement_group = aws_placement_group.web.id

  tags = {
    Name = "Web-Server1"
  }
}

resource "aws_placement_group" "web" {
  name     = "hunky-dory-pg"
  strategy = "cluster"
}

resource "aws_security_group" "allow_tls" {
  name        = "my-sec1"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = "vpc-0aaf15e6174def8a4"

  tags = {
    Name = "my-secity1"

}



  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]


  }


}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------

* access_key create


resource "aws_instance" "web" {
  ami             = "ami-07c589821f2b353aa"
  instance_type   = "c5.xlarge"
  security_groups = [aws_security_group.allow_tls.name]
  placement_group = aws_placement_group.web.id
  key_name          = "new-key"


  tags = {
    Name = "Web-Server1"
  }
}

resource "aws_placement_group" "web" {
  name     = "hunky-dory-pg"
  strategy = "cluster"
}

resource "aws_key_pair" "deployer" {
  key_name   = "new-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCa8q8s4jvvxtwWJJBAAhR1jxbLTcNIvU3n8a2dSI5I9Ded/DHmNfrzzF2yYTvWTQXxRdxYkQ/TO6rtfgH6US1soJa4yHRzMMXA849RLVZ1Sl+7XmXFeYQLoyGxK6Vke1MZNqz+PwujB+YC2GfIRSe4avDHRU+ymleJViofcsaBiBA7mDkqMa8BLVMMQh1JIlXq0OyURV6f3KwRaA/ZCQWa/44T4nyU2qAAxwy0+bE5/+JwjkxiF41fgDWTfZlP104STEg8QngInTdo3EURo35kUNU81mQk+AjVDtBNhuNbGKUiV5Ja/kfrmDeuFMIq2BJtuX6lFDzNKoX/v2O/GbRHQqq6Ks4NeIwzcA984RDwt1CIj7GvhBKB7QvP3+xIGwK+kADUH/Qv/cdcEUpAUwjSGFewt1EMdTng9JrzrTWKPtv+4DQy8RiDRJx7RflDqKx1cvL6fgA5SFqZmM6eIOf3DCJm8uyp4xriiJRKzPp+v4fYn891X+LnND2a+plGoZ0= root@ip-172-31-15-25"
}



resource "aws_security_group" "allow_tls" {
  name        = "my-sec1"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = "vpc-0aaf15e6174def8a4"

  tags = {
    Name = "my-secity1"

}



  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]


  }


}


-------------------------------------------------------------------------------------------------------------------------------------------------------------------


