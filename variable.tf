
variable "public_subnet_cidr" {
  description = "nike main public subnet cidrs"
  type = list(string)
  default = [ "10.0.1.0/24" , "10.0.2.0/24" , "10.0.3.0/24" ]
}

variable "private_subnet_cidr" {
  description = "private subnet cidr values"
  type = list(string)
  default = [ "10.0.4.0/24" , "10.0.5.0/24"  ]  //, "10.0.6.0/24"
}

variable "azs" {
  description = "availability zones"
  type = list(string)
  default = [ "us-east-1a" , "us-east-1b" ]
}

