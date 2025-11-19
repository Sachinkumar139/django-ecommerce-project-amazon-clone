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
resource "aws_elastic_beanstalk_application" "django_app" {
  name        = "django-ecommerce-project-amazon-clone"
  description = "Django Elastic Beanstalk app"
}

resource "aws_elastic_beanstalk_environment" "django_env" {
  name                = "django-env"
  application         = aws_elastic_beanstalk_application.django_app.name
  solution_stack_name = "64bit Amazon Linux 2 v3.9.0 running Python 3.11"
}

