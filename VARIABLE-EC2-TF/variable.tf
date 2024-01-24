variable "instance_type" {
  type    = list(any)
  default = ["t3.micro", "t2.medium", "c5.xlarge"]

}

variable "instace_tags" {
  type = map(string)
  default = {
    Name = "Web-Server"
    team = "Devops"
  }
}


variable "instance_az" {
  type    = string
  default = "ap-northeast-1a"
}

variable "sg_name" {
  type    = string
  default = "web_sg"
}

variable "sg_description" {
  type    = string
  default = "Allow TLS inbound traffic and all outbound traffic"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0aaf15e6174def8a4"
}


variable "sg_tags" {
  type = map(string)
  default = {
    name = "sg_web"
  ports = "80,22" }

}

variable "placement_group"{
   type = string
   default = "cluster"
}
