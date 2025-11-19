variable "region" {
    type = string
    description = "this is the region template"
    default = "ap-south-1"
}

variable "network_info" {
  description = "this is vpc info"

  type = object({
    name = string
    cidr = string
    private_subnets = list(object({
      name = string
      cidr = string
      az   = string
    }))
    public_subnets = list(object({
      name = string
      az = string
      cidr = string
    }))
  })
  default = {
    name = "nop"
    cidr = "10.0.0.0/16"

    private_subnets = [
      {
        name = "db1"
        az   = "ap-south-1a"
        cidr = "10.0.2.0/24"
      },
      {
        name = "db2"
        cidr = "10.0.3.0/24"
        az   = "ap-south-1b"
      }]
      public_subnets = [ {
        name = "app1"
        az = "ap-south-1a"
        cidr = "10.0.0.0/24"
      },{
        name = "app2"
        az = "ap-south-1b"
        cidr = "10.0.1.0/24"
      
        
      } ]
      
  }
}