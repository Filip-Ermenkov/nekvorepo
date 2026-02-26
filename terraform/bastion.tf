# data "aws_ami" "amazon_linux_2023" {
#   most_recent = true
#   owners      = ["amazon"]
#   filter {
#     name   = "name"
#     values = ["al2023-ami-*-x86_64"]
#   }
# }
# 
# resource "aws_instance" "bastion" {
#   ami           = data.aws_ami.amazon_linux_2023.id
#   instance_type = "t3.nano"
#   subnet_id     = module.vpc.public_subnets[0]
# 
#   vpc_security_group_ids = [aws_security_group.bastion_sg.id]
#   key_name               = var.ssh_key_name
# 
#   tags = {
#     Name = "Gatekeeper-Bastion"
#   }
# }