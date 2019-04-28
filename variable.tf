variable "AWS_REGION" {
  default = "us-east-2"
}
variable "private_key" {
  default = "nextkey"
}
variable "public_key" {
  default = "nextkey.pub"
}

variable "alarms_email" {
  default = "youremail@com"
}

variable "AMIS" {
  type = "map"
  default = {
    us-east-2 = "ami-0c55b159cbfafe1f0" #ubuntu

  }
}
