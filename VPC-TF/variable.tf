variable "vpc_cird" {
    type = string
    default = "192.168.0.0/16"
}
    variable "vpc_tenancy"{
        type= string
        default = "default"
    }


variable "vpc_tags" {
    type = map(string)
    default = {
        Name = "My-vpc"
        team = "Devops"
    }

}


variable "public_subnet_cidrs" {
    type = list(string)
    default = [ "192.168.0.0/24","192.168.1.0/24","192.168.2.0/24" ]

}

variable "subnet_az" {
    type = list(string)
    description = "Availability Zones"
    default = [ "ap-northeast-1a","ap-northeast-1c","ap-northeast-1d" ]


}

variable "Subnet_tag1" {
    type = map(string)
    default = {
      "Name" = "public-1"
    }

}

variable "Subnet_tag2" {
    type = map(string)
    default = {
      "Name" = "public-2"
    }

}

variable "Subnet_tag3" {
    type = map(string)
    default = {
      "Name" = "public-3"
    }

}

variable "private_subnet_cidrs" {
    type = list(string)
    default = [ "192.168.3.0/24","192.168.4.0/24","192.168.5.0/24" ]

}

variable "subnet_tag4" {
    type = map(string)
    default = {
      "Name" = "private-1"
    }

}


variable "subnet_tag5" {
    type = map(string)
    default = {
      "Name" = "private-2"
    }

}

variable "subnet_tag6" {
    type = map(string)
    default = {
      "Name" = "private-3"
    }

}
