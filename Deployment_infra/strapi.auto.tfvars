cidr_block = "10.0.0.0/16"

public_subnets = [
  "10.0.1.0/24",
  "10.0.4.0/24"
]

private_subnets = [
  "10.0.2.0/24",
  "10.0.3.0/24"
]

availability_zones = [
  "us-east-1a",
  "us-east-1b"
]

ami_id = "ami-020cba7c55df1f615"

instance_type = "t3.medium"

key_name = "strapi-key"


private_key_path = "../../../../Downloads/strapi-key.pem"

notification_email = "devcode752@gmail.com"