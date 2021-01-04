variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}
variable "key_pair_name" {}

provider "aws" {
    region = "eu-west-1"
    access_key = var.aws_access_key_id
    secret_key = var.aws_secret_access_key
}

resource "aws_security_group" "allow_ssh"{
    name        = "kn-allow_ssh-sg"
    description = "Allows connections using SSH from one public ip"
    
    ingress {
        description = "allow ssh from home"
        protocol    = "tcp"
        from_port   = "22"
        to_port     = "22"
    }
    tags = {
        Name    = "kn-allow_ssh-sg"
        Source  = "Terraform"
    } 
}
resource "aws_instance" "terraform" {
    ami = "ami-06ce3edf0cff21f07" 
    instance_type = "t2.micro"
    key_name = var.key_pair_name
    tags = {
        Name = "kn-terra-test"
        Source  = "Terraform"
        Creator = "Kamil Nowak"
    }
}

output "public ip" {
    value       = aws_instance.terraform.public_ip
    description = "Public ip of created VM"
}
