resource "aws_security_group" "strapi_security_group_bastion_host" {
  name        = "strapi_security_group_bastion_host"
  description = "Security group for Strapi bastion host"
  vpc_id      = var.vpc_id
  
}


resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.strapi_security_group_bastion_host.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.strapi_security_group_bastion_host.id
  cidr_ipv6         = "::/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.strapi_security_group_bastion_host.id
  cidr_ipv4         = "0.0.0.0/0"
    from_port         = 22 
    ip_protocol       = "tcp"
    to_port           = 22
  
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.strapi_security_group_bastion_host.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic from the bastion host SG"
}
 

resource "aws_security_group" "ALB_Security_Group" {
  name        = "ALB_Security_Group"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id
  
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.ALB_Security_Group.id
  cidr_ipv4         = "0.0.0.0/0"
    from_port         = 80
    ip_protocol       = "tcp"
    to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_strapi" {
  security_group_id = aws_security_group.ALB_Security_Group.id
  cidr_ipv4         = "0.0.0.0/0"
    from_port         = 1337
    ip_protocol       = "tcp"
    to_port           = 1337
  
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_alb" {
  security_group_id = aws_security_group.ALB_Security_Group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic from the ALB SG"
}



resource "aws_security_group" "strapi_security_group" {
  name        = "strapi_security_group"
  description = "Security group for Strapi instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  
}


  tags = {
    Name = "StrapiSecurityGroup"
  }
}



resource "aws_security_group" "lambda_sg" {
  name        = "lambda-cleanup-sg"
  description = "SG for ECS cleanup Lambda"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
