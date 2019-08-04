# variables.tf
variable "region" {
  default = "us-west-1"
  #default = "us-east-1"
}

variable "tagnames" {
  default = "DEV_TEST1"
}

variable "key_name" {
  default = "aws1"
}

variable "key_path" {
  default = "/home/edj/.ssh/aws1.pem"
}


variable "pub_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2txoeggb+Vv4cXvgVJM+LFUU/IErXyRoWMxxVWzm1V1y06gagiJjoMjzPJtXtMxW5RB0zeEzYIvl/FTK0gU5/9SuyfowcoC1AuPWUoz4aE/nRu3nZy9UNExs8pvBiM4COHgsP4VsGUq1uepujU+B/gkw7R6A9a3WM460sVveQWj30o1nt1IFksYmyb1PIpiS6hM+Z85ww/PlXkDOtQihYzzj8rBLU9Kwe+TG15Dk4VY8YDQSL+K6NV6b8nZJl5w8heRKfbrEYeFxsaHJFojGrNLo6k8rnWPM1IfAFxwR0MXYxsUZayY3YVfj3T6jbGI3AlbKSyUjX4D9V3c3wq0En edj@ubuntu18"
}

variable "availabilityZone" {
  default = "us-west-1a"
}

variable "instanceTenancy" {
  default = "default"
}

variable "dnsSupport" {
  default = true
}

variable "dnsHostNames" {
  default = true
}

variable "vpcCIDRblock" {
  default = "10.0.0.0/16"
}

variable "subnetCIDRblock" {
  default = "10.0.1.0/24"
}

variable "destinationCIDRblock" {
  default = "0.0.0.0/0"
}

variable "ingressCIDRblock" {
  type    = list(string)
  default = ["90.254.132.108/32"]
}

variable "mapPublicIP" {
  default = true
}

variable "os-version" {
  description = "Whether to use ubuntu 14 or ubuntu 16"
  default     = "ubuntu14"
}


# end of variables.tf
