provider "aws" {
  region                  = "ap-northeast-2"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "deploy_terraform"
}

resource "aws_vpc" "SimpleVPC" {
  cidr_block       = "10.21.0.0/16"
  assign_generated_ipv6_cidr_block = true
}

resource "aws_internet_gateway" "SimpleIGW" {
  vpc_id = "${aws_vpc.SimpleVPC.id}"
}

resource "aws_subnet" "SimpleSubnet" {
  vpc_id = "${aws_vpc.SimpleVPC.id}"
  cidr_block = "10.21.0.0/24"
}

resource "aws_route_table" "SimpleRouteTable" {
  vpc_id = "${aws_vpc.SimpleVPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.SimpleIGW.id}"
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = "${aws_internet_gateway.SimpleIGW.id}"
  }

}
resource "aws_network_acl" "SimpleNACL" {
  vpc_id = "${aws_vpc.SimpleVPC.id}"
  subnet_ids= ["${aws_subnet.SimpleSubnet.id}"]
}
resource "aws_network_acl_rule" "SimpleNACLIngressSSH" {
  network_acl_id =  "${aws_network_acl.SimpleNACL.id}"
  rule_number    = 1
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "SimpleNACLIngressHTTP" {
  network_acl_id =  "${aws_network_acl.SimpleNACL.id}"
  rule_number    = 10
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}
resource "aws_network_acl_rule" "SimpleNACLIngressHTTPS" {
  network_acl_id =  "${aws_network_acl.SimpleNACL.id}"
  rule_number    = 11
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "SimpleNACLEgressHTTP" {
  network_acl_id =  "${aws_network_acl.SimpleNACL.id}"
  rule_number    = 10
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
  egress         = true
}

resource "aws_network_acl_rule" "SimpleNACLEgressHTTPS" {
  network_acl_id =  "${aws_network_acl.SimpleNACL.id}"
  rule_number    = 11
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
  egress         = true
}
resource "aws_network_acl_rule" "SimpleNACLEgressTemp" {
  network_acl_id =  "${aws_network_acl.SimpleNACL.id}"
  rule_number    = 100
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 32768
  to_port        = 65535
  egress         = true
}