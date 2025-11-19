resource "aws_vpc" "main" {
    cidr_block = var.network_info.cidr
  tags = {
    Name = var.network_info.name
  }
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.network_info.public_subnets)
  availability_zone = var.network_info.public_subnets[count.index].az
  cidr_block        = var.network_info.public_subnets[count.index].cidr
  vpc_id            = aws_vpc.main.id
  tags = {
    Name = var.network_info.public_subnets[count.index].name
  }
  depends_on = [aws_vpc.main]
}
resource "aws_subnet" "private_subnets" {
  count             = length(var.network_info.private_subnets)
  availability_zone = var.network_info.private_subnets[count.index].az
  cidr_block        = var.network_info.private_subnets[count.index].cidr
  vpc_id            = aws_vpc.main.id
  tags = {
    Name = var.network_info.private_subnets[count.index].name
  }
  depends_on = [aws_vpc.main]
}
resource "aws_instance" "ec2-instance" {
  ami = "ami-080b4e8311df57073"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnets.id
  key_name = "byaws"
  associate_public_ip_address = True

  tags = {
    Name = "ubuntu"
  }
}
