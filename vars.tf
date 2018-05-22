variable "aws_key_name" {
  description = "provide the key that you provide through aws cli command"
  default     = ""
}

variable "my_private_key_path" {
  description = "Enter the path to the SSH Private Key to run provisioner."
  default = "~/.ssh/id_rsa"
}
