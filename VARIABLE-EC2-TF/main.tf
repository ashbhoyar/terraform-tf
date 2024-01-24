resource "aws_instance" "web" {
  ami                = "ami-07c589821f2b353aa"
  instance_type      = var.instance_type[1]
  availability_zone = var.instance_az
  security_groups    = [aws_security_group.allow_tls.name]
  placement_group = aws_placement_group.web.id


  tags = var.instace_tags

}

resource "aws_security_group" "allow_tls" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id

  tags = var.sg_tags


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

resource "aws_placement_group" "web" {
  name     =  "mypgroup"
  strategy = var.placement_group
}
