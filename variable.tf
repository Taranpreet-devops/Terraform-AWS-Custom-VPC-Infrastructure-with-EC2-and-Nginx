variable "aws_instance_type" {
  default = "t3.micro"
  type = string
}
variable "block_store_size"{
    default=15
    type= number
}
variable "ec2_ami_id"{
    default ="ami-0b6c6ebed2801a5cb"
    type = string
}