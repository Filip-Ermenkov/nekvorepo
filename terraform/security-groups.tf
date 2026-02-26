# resource "aws_security_group" "bastion_sg" {
#   name        = "${var.project_name}-bastion-sg"
#   description = "Allow SSH to Bastion"
#   vpc_id      = module.vpc.vpc_id
# 
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["${var.my_ip}/32"] # Strictly whitelists ONLY your current IP
#   }
# 
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow direct access from dev IP"
  vpc_id      = module.vpc.vpc_id

  # # Allow the Bastion to tunnel in
  # ingress {
  #   from_port       = 5432
  #   to_port         = 5432
  #   protocol        = "tcp"
  #   security_groups = [aws_security_group.bastion_sg.id]
  # }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"] 
  }

  # Allow future EKS apps inside the VPC to connect
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}