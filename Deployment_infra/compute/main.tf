resource "aws_instance" "strapi_instance" {
  count         = length(var.subnet_id)
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.strapi_security_group_id]
  subnet_id              = var.subnet_id[count.index]

  user_data = <<-EOF
    #!/bin/bash
    set -e

    # Update the system
    apt-get update -y
    apt-get upgrade -y

    # Install prerequisites
    apt-get install -y \
      ca-certificates \
      curl \
      gnupg \
      lsb-release

    # Add Docker's official GPG key
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
      gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    # Set up Docker repository
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Update again with Docker repo
    apt-get update -y

    # Install Docker engine and plugins
    apt-get install -y \
      docker-ce \
      docker-ce-cli \
      containerd.io \
      docker-buildx-plugin \
      docker-compose-plugin

    # Enable and start Docker
    systemctl enable docker
    systemctl start docker

    # Pull and run your Docker image
    docker pull gillnavi/strapi-nini
    docker run -d --name strapi-app -p 1337:1337 gillnavi/strapi-nini
  EOF

  # Uncomment the following blocks to upload files to /strapi
  # connection {
  #   type        = "ssh"
  #   user        = "ubuntu"
  #   private_key = file(var.private_key_path)
  #   host        = self.public_ip
  # }

  # provisioner "remote-exec" {
  #   inline = ["mkdir -p /strapi"]
  # }

  # provisioner "file" {
  #   source      = "../strapi/docker-compose.yml"
  #   destination = "/strapi/docker-compose.yml"
  # }

  # provisioner "file" {
  #   source      = "../strapi/.env"
  #   destination = "/strapi/.env"
  # }

  # provisioner "file" {
  #   source      = "../strapi/nginx.conf"
  #   destination = "/strapi/nginx.conf"
  # }

  tags = {
    Name = "strapi-ec2"
  }
}

resource "aws_instance" "strapi_bastion_host" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [var.bastion_security_group_id]
  subnet_id              = var.public_subnet_ids[0]
}
